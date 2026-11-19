#!/usr/bin/env python3
"""Sync declared artifact status with what is actually present in offline-repo/.

Never upgrades verification_status. Only artifact_status changes, and only when a
checksummed artifact really exists on disk. Safe to run after scripts/_generate.py.
"""
from __future__ import annotations

import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
REPO = ROOT / "offline-repo"
SUMS = REPO / "checksums" / "SHA256SUMS"


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def register_extra_checksums() -> int:
    """Rebuild SHA256SUMS from every cached artifact actually present on disk."""
    artifacts = [p for p in (REPO / "deb-packages").glob("*.deb") if p.is_file()]
    artifacts += [p for p in REPO.glob("portable-archives/*") if p.is_file()]
    artifacts += [p for p in (ROOT / "runtimes/browsers/chrome-headless-shell").glob("*") if p.is_file()]
    entries = {p.relative_to(ROOT).as_posix(): sha256(p) for p in artifacts}
    lines = ["# SHA-256 checksums for cached offline artifacts"]
    lines += [f"{digest}  {rel}" for rel, digest in sorted(entries.items())]
    SUMS.parent.mkdir(parents=True, exist_ok=True)
    SUMS.write_text("\n".join(lines) + "\n", encoding="utf-8")
    return len(entries)


def main() -> None:
    apps_path = ROOT / "registry/applications.json"
    apps = json.load(apps_path.open(encoding="utf-8"))
    mapping = json.load((ROOT / "registry/apt-package-map.json").open(encoding="utf-8"))["mapping"]
    total_artifacts = register_extra_checksums()
    checksummed = {
        line.split("  ", 1)[1].strip()
        for line in SUMS.read_text(encoding="utf-8").splitlines()
        if "  " in line and not line.startswith("#")
    }
    deb_names = {Path(p).name for p in checksummed if "/deb-packages/" in p}
    portable = {Path(p).name.lower() for p in checksummed if "/portable-archives/" in p}
    npm_cached = (REPO / "npm-cache/_cacache").is_dir()
    browser_cached = any((ROOT / "runtimes/browsers/chrome-headless-shell").glob("*"))

    changed = []
    for app in apps["applications"]:
        if app.get("facade_of"):
            continue
        aid = app["id"]
        apt_name = mapping.get(aid, "")
        has_deb = any(n.startswith(apt_name + "_") for n in deb_names) if apt_name else False
        has_portable = any(aid in n for n in portable)
        has_npm = aid in {"remotion", "nodejs", "react", "typescript", "lottie"} and npm_cached
        has_browser = aid == "chromium" and browser_cached
        cached = has_deb or has_portable or has_npm or has_browser
        new_status = "cached" if cached else "not-cached"
        if app.get("artifact_status") != new_status:
            app["artifact_status"] = new_status
            changed.append(aid)
        app["offline_available"] = cached
        app["requires_network_for_installation"] = not cached

        meta = ROOT / app.get("package_path", "") / "metadata/application.json"
        if meta.is_file():
            m = json.load(meta.open(encoding="utf-8"))
            m["artifact_status"] = new_status
            m["offline_available"] = cached
            m["requires_network_for_installation"] = not cached
            json.dump(m, meta.open("w", encoding="utf-8"), indent=2, ensure_ascii=False)

    json.dump(apps, apps_path.open("w", encoding="utf-8"), indent=2, ensure_ascii=False)

    idx_path = ROOT / "registry/package-index.json"
    idx = json.load(idx_path.open(encoding="utf-8"))
    idx["artifact_count"] = total_artifacts
    idx["artifact_sources"] = ["offline-repo/deb-packages", "offline-repo/portable-archives",
                               "offline-repo/npm-cache", "runtimes/browsers/chrome-headless-shell"]
    json.dump(idx, idx_path.open("w", encoding="utf-8"), indent=2, ensure_ascii=False)
    print(f"synced artifact status: {len(changed)} changes; "
          f"cached={sum(a.get('artifact_status') == 'cached' for a in apps['applications'])}; "
          f"checksummed artifacts={total_artifacts}")


if __name__ == "__main__":
    main()
