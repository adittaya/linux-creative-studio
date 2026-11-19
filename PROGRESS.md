# Progress manifest

Date: 2026-11-19

## Completed
- Phase 1: upstream research for key applications; versions recorded with research dates.
- Phase 2: full directory structure, 75 application metadata packages, registry indexes, capability
  index, dependency index, compatibility matrix, 20 task profiles and the `studioctl` control plane.
- Phase 3: **offline artifact bundle populated.** 1,615 SHA-256-verified `.deb` packages from the
  internally consistent Ubuntu 24.04 noble base repository (full dependency closure for 50+ open-source
  apps), plus official portable Blender 5.3.0 and the pinned Remotion Chrome Headless Shell + npm cache.
- Phase 4: license-cleared templates and presets (Blender scene, Kdenlive MLT, Remotion starter, OCIO,
  export/color/video/audio/animation presets). Third-party stock media remains license-gated by design.
- Phase 5: discovery, capability search, task planning, guarded launch, verify, doctor and JSON output.
- Phase 6: modular adapters and installers with dry-run, explicit system-change confirmation and a
  local file: apt repository (`scripts/create-repository.sh apt`).
- Phase 7: functional tests executed in the preparation environment — FFmpeg/FFprobe probe, Blender
  headless render and Remotion offline render **PASSED**; GIF/ImageMagick and OCIO tests SKIPPED.
- Phase 8: transfer-ready offline bundle with `OFFLINE_BUNDLE_MANIFEST.json`, checksums and provenance.

## Not completed / honest limitations
- No test has been executed on a clean, isolated target host. `offline-verified` is still false.
- 20 registered applications remain `unavailable`, `not-redistributable` or capability facades with no
  redistributable binary. DaVinci Resolve and REAPER are documented but never bundled.
- GUI applications were not launched interactively; no target-host driver/GPU validation was performed.
- Assets/plugins that require third-party licences are intentionally absent.

## Rule
No status may be upgraded to `verified` or `offline-verified` until the corresponding test in
`tests/` has been executed on a target machine and its log stored under `logs/`.
