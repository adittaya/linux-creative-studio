# Linux Creative Studio — offline-first creative production environment

A **discoverable, modular creative software ecosystem** for Debian/Ubuntu-family Linux systems.
It is designed so that a separate AI agent can inspect the installation, choose the correct tool for a
creative task, understand its dependencies, launch it safely, and follow a documented workflow.

> **Honest state (2026-11-19):** this is a **populated offline bundle**, not just a scaffold.
> It contains 75 application manifests, 168 capabilities, 20 task profiles, a working `studioctl` CLI,
> **1,615 SHA-256-verified Ubuntu 24.04 `.deb` packages** (full dependency closure for 50+ apps),
> official portable **Blender 5.3.0**, the pinned **Remotion** npm cache and Chrome Headless Shell.
> Blender headless rendering, Remotion offline rendering and FFmpeg/FFprobe probing **passed** here.
> It has **not** been validated on a clean target host, so `offline-verified` remains false.

## What is included now

| Layer | Status | Location |
|---|---|---|
| Directory architecture | Complete | `packages/`, `runtimes/`, `plugins/`, `assets/`, `templates/`, `presets/`, `profiles/`, `offline-repo/`, `scripts/`, `docs/`, `tests/` |
| Application manifests | 75 apps, 51 with cached artifacts | `registry/applications.json`, `packages/<category>/<id>/metadata/` |
| Capability index | 168 capabilities | `registry/capabilities.json` |
| Dependency index | Complete | `registry/dependencies.json` |
| Compatibility matrix | Ubuntu 24.04 noble/amd64 pinned, target untested | `COMPATIBILITY.md`, `registry/compatibility.json` |
| Task profiles | 20 profiles | `registry/task-profiles.json`, `profiles/` |
| AI CLI | Working | `studioctl` |
| Offline artifact repositories | 1,615 `.deb` + Blender + browser + npm cache | `offline-repo/`, `runtimes/browsers/` |
| Installation adapters | Guarded local file: apt repo | `scripts/install.sh`, `installers/` |
| Functional tests | 3 passed, others honestly skipped | `tests/`, `logs/test-*.json` |

## Quick start (works without installing anything)

```bash
cd Linux-Creative-Studio
./studioctl status
./studioctl doctor
./studioctl list --category 3d
./studioctl search "color grading" --json
./studioctl plan --task "Create a 3D animated product video" --json
./studioctl info remotion
./studioctl capabilities
./studioctl offline-check --json
```

`studioctl launch <id> --dry-run` shows exactly which allowlisted executable would be used.
If the application is not installed, the command tells you which installation methods are supported.

## Coverage

- **2D image/design:** GIMP, Krita, Inkscape, Scribus, darktable, RawTherapee, digiKam, MyPaint,
  Pinta, FontForge, ImageMagick, G'MIC, libvips, ExifTool
- **2D animation:** Tahoma2D, OpenToonz, Synfig, Glaxnimate, Pencil2D, Krita Animation
- **3D:** Blender (modeling, sculpting, UV, texturing, rigging, Geometry Nodes, Grease Pencil,
  simulation, Eevee/Cycles, compositing), FreeCAD, MeshLab, OpenSCAD, Material Maker, Meshroom,
  Assimp, Open Image Denoise, LuxCoreRender
- **2.5D/VFX:** Blender Compositor, Natron, Glaxnimate, GIMP, Krita; parallax, camera projection,
  tracking, keying, rotoscoping, masking and multi-layer compositing
- **Video:** Kdenlive, Shotcut, OpenShot, Flowblade, Avidemux, LosslessCut, HandBrake,
  Shutter Encoder, MLT
- **Color:** OpenColorIO, ACES, ArgyllCMS, DisplayCAL, Blender color management, LUT library,
  optional DaVinci Resolve (separate, non-redistributable track)
- **Motion/programmatic:** Remotion, Node.js LTS, npm/pnpm, React, TypeScript, Chromium,
  FFmpeg/FFprobe, Lottie and SVG tooling
- **Audio:** Audacity, Ardour, REAPER (optional commercial), LMMS, Carla, PipeWire, JACK, ALSA,
  LADSPA/LV2/LSP/Calf/x42 plugin collections
- **Infrastructure:** FFmpeg, GStreamer, MediaInfo, MKVToolNix, VLC, mpv, Python 3, Git, jq, 7-Zip

## Key design rules

1. **Offline-first, not offline-pretending.** Cached artifacts are recorded as `cached` only when a
   real file exists and is listed in `offline-repo/checksums/SHA256SUMS`. Licence-gated packages are
   explicitly `not-redistributable` and are never bundled.
2. **No system damage.** Scripts never replace glibc, system Python, kernels or graphics drivers.
   `.deb` installation requires explicit `--confirm-system-change`.
3. **Safe launches.** `studioctl launch` resolves only allowlisted executables, uses argv arrays,
   never `shell=True`, and validates `--input` paths/extensions.
4. **Capability-first discovery.** Search by task, not by package name. `studioctl plan` returns a
   reasoned toolchain with dependencies and install/verification state.
5. **Capability facets.** Blender Compositor, Blender Grease Pencil, Krita Animation, FFprobe and
   Blender Color Management are indexed as facets of their parent application — discoverable by task,
   but not fake binaries.

## Documentation

- `INSTALL.md` — installation methods and profiles
- `OFFLINE_GUIDE.md` — preparation machine → USB bundle → offline target workflow
- `AI_AGENT_GUIDE.md` — machine-readable contract and safe automation patterns
- `COMPATIBILITY.md` — supported distributions, architectures, known caveats
- `SECURITY.md` — checksums, provenance, safe installation
- `LICENSES.md` — redistribution rules and commercial software separation
- `TROUBLESHOOTING.md` — common failures and diagnostics
- `PROGRESS.md` — what is actually done vs outstanding
