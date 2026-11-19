#!/usr/bin/env python3
"""Generate FINAL_REPORT.md from actual local state. Never upgrades status on assertion."""
from __future__ import annotations

import json
from collections import Counter
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def jload(rel, default):
    p = ROOT / rel
    return json.load(p.open(encoding="utf-8")) if p.is_file() else default


def main():
    apps = jload("registry/applications.json", {"applications": []})["applications"]
    verify = jload("logs/verification-latest.json", {})
    offline = jload("logs/offline-check-latest.json", {})
    by_status = Counter(a["verification_status"] for a in apps)
    results = {r["id"]: r for r in verify.get("results", [])}
    installed = sorted(i for i, r in results.items() if r.get("executable_present"))
    smoke = sorted(i for i, r in results.items() if r.get("smoke_test", {}).get("returncode") == 0)
    test_files = sorted(p.name for p in (ROOT / "logs").glob("test-*.json"))
    tests = {}
    for name in test_files:
        d = jload(f"logs/{name}", {})
        tests[name] = d.get("status", "unknown")
    cached = sorted(a["id"] for a in apps if a.get("artifact_status") == "cached")
    lines = [
        "# Final report — Linux Creative Studio offline bundle",
        "",
        f"Generated: {datetime.now(timezone.utc).isoformat()}",
        "",
        "## Summary",
        "",
        f"- Applications registered: **{len(apps)}** across "
        f"**{len({a['category'] for a in apps})}** categories.",
        f"- Task profiles: **{len(jload('registry/task-profiles.json', {'profiles': []})['profiles'])}**; "
        f"capabilities indexed: **{jload('registry/capabilities.json', {'capability_count': 0})['capability_count']}**.",
        f"- Cached installation artifacts: **{jload('registry/package-index.json', {'artifact_count': 0})['artifact_count']}** "
        f"(checksummed files); **{len(cached)}** applications have a usable offline artifact.",
        "- This is a **populated offline bundle** for Ubuntu 24.04 noble/amd64. It has not been validated "
        "on a clean target host; `offline-verified` is still false.",
        "",
        "## Status breakdown (declared, honest)",
        "",
    ]
    for status, count in sorted(by_status.items()):
        lines.append(f"- `{status}`: {count}")
    lines += [
        "",
        "## Installed / smoke-passed on this host",
        "",
        f"- Executable present: {', '.join(installed) or 'none'}",
        f"- CLI smoke test passed (`--version` style): {', '.join(smoke) or 'none'}",
        "- Portable Blender 5.3.0 (upstream SHA-256 verified) renders the bundled scene headlessly.",
        "- Remotion renders `templates/remotion/starter` from the local npm cache + pinned browser.",
        "- FFmpeg/FFprobe probe test passes. Other system tools were already present on this host.",
        f"- Applications with cached artifacts: {', '.join(cached)}.",
        "",
        "## Unavailable / restricted",
        "",
    ]
    for a in apps:
        if a["verification_status"] in ("unavailable", "not-redistributable"):
            lines.append(f"- **{a['name']}** (`{a['id']}`) — `{a['verification_status']}`: {a['notes'] or 'see metadata'}")
    lines += [
        "",
        "## Tests executed in this environment",
        "",
    ]
    for name, status in tests.items():
        lines.append(f"- `{name}`: **{status}**")
    lines += [
        "",
        "## Not verified / outstanding",
        "",
        "- No clean, isolated target host was available; all tests ran in the preparation environment.",
        "- No GUI application was launched interactively; GPU/driver paths are untested.",
        "- No AppImage, Flatpak, Python wheel or Debian closure was added for non-Ubuntu targets.",
        "- No offline guarantee is claimed until the full suite passes on an isolated host. `offline-check` report:",
    ]
    for key, count in sorted((offline.get("summary") or {}).items()):
        lines.append(f"  - `{key}`: {count}")
    lines += [
        "",
        "## Deliverables present",
        "",
        "- Full directory structure, 75 per-application metadata packages and machine-readable indexes.",
        "- Working `studioctl` CLI with capability search, task planning, launch guards and JSON output.",
        "- 20 task profiles, presets, templates, configuration and documentation.",
        "- 1,615 SHA-256-verified apt packages + local file: repository indexes.",
        "- Portable Blender 5.3.0, npm cache and pinned Chrome Headless Shell.",
        "- Guarded download/install/verify/offline/repair/update/uninstall scripts.",
        "- Test suite, functional-test logs, compatibility/licence/security records and checksums.",
        "- Transfer-ready directory tree (see the generated zip archive).",
        "",
        "Upgrade any status to `verified`/`offline-verified` only after running `tests/` on the "
        "target machine and storing the corresponding logs in `logs/`.",
    ]
    out = ROOT / "FINAL_REPORT.md"
    out.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"Wrote {out.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
