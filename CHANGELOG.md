# Changelog

## 1.0.0 — 2026-11-19 — foundation

- Added full required directory architecture under `Linux-Creative-Studio/`.
- Added machine-readable manifests for 80+ applications across 9 categories, including capability
  facets for Blender Compositor, Blender Colour Management, Krita Animation and FFprobe.
- Added capability index, dependency index, compatibility matrix, licence inventory, plugin/runtime
  registries and package index.
- Added 20 reusable task profiles with workflows and validation procedures.
- Implemented `studioctl` with `list`, `search`, `info`, `capabilities`, `plan`, `launch`, `verify`,
  `doctor`, `offline-check`, `status`, `deps`, `profiles` and `detect`, all with JSON output.
- Implemented guarded launch (allowlisted paths, argv arrays, input validation, `--dry-run`).
- Implemented system/hardware detection, verified-artifact downloader, modular installer, verification,
  offline check, repair, update, uninstall and repository index scripts.
- Documented README, INSTALL, OFFLINE_GUIDE, AI_AGENT_GUIDE, COMPATIBILITY, SECURITY, LICENSES,
  TROUBLESHOOTING and per-application pages.
- Recorded honest status: no artifacts downloaded, no applications installed or functionally tested.
