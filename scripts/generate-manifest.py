#!/usr/bin/env python3
"""Generate the final transfer manifest for an offline bundle.

Reads only local state. Never claims a test passed unless a log exists in logs/.
"""
from __future__ import annotations

import json
import os
import platform
import shutil
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def jload(rel, default):
    p = ROOT / rel
    return json.load(p.open(encoding="utf-8")) if p.is_file() else default


def sha256(path: Path) -> str:
    import hashlib
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def main():
    apps = jload("registry/applications.json", {"applications": []})["applications"]
    checks = jload("logs/verification-latest.json", {})
    offline = jload("logs/offline-check-latest.json", {})
    doctor = jload("logs/doctor-latest.json", {})
    checksums = ROOT / "offline-repo/checksums/SHA256SUMS"
    artifacts = []
    if checksums.is_file():
        for line in checksums.read_text().splitlines():
            if line and not line.startswith("#") and "  " in line:
                digest, rel = line.split("  ", 1)
                p = ROOT / rel
                artifacts.append({"path": rel, "sha256": digest, "exists": p.is_file()})
    tested = {r["id"]: r for r in checks.get("results", [])}
    bundle = {
        "schema_version": "1.0",
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "generator": "scripts/generate-manifest.py",
        "host": {"system": platform.system(), "release": platform.release(),
                 "machine": platform.machine(), "python": platform.python_version()},
        "studio": {"root": str(ROOT), "application_count": len(apps),
                   "profile_count": len(jload("registry/task-profiles.json", {"profiles": []})["profiles"])},
        "artifacts": artifacts,
        "artifact_count": len(artifacts),
        "verification": {
            "structural_results": {k: v["verdict"] for k, v in tested.items()},
            "offline_summary": offline.get("summary", {}),
            "doctor_problems": doctor.get("problems", []),
            "functional_tests": "no test logs found" if not list((ROOT / "logs").glob("test-*.json")) else "see logs/test-*.json",
        },
        "licenses": {a["id"]: a["license_type"] for a in apps},
        "restricted": [a["id"] for a in apps if "restricted" in a["license_type"]],
        "honest_status": {
            "foundation_complete": True,
            "artifacts_downloaded": len(artifacts) > 0,
            "applications_functionally_verified": bool(tested) and all(
                v.get("verdict") == "smoke-passed" for v in tested.values()),
            "offline_verified": False,
        },
        "notes": "Upgrade status fields only after executing tests/ on a target machine and storing logs.",
    }
    out = ROOT / "OFFLINE_BUNDLE_MANIFEST.json"
    out.write_text(json.dumps(bundle, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print(f"Wrote {out.relative_to(ROOT)} with {len(artifacts)} artifact(s).")


if __name__ == "__main__":
    main()
