# Pencil2D — application notes

**Purpose.** Lightweight traditional 2D frame-by-frame animation
**Suitable tasks.** Lightweight traditional 2D frame-by-frame animation
**Capabilities.** 2d-animation, frame-by-frame, sketching, onion-skin
**Formats.** pclx, pcl, png, gif, mp4, webp
**Install methods.** distribution-package, flatpak, official-appimage, flatpak, distribution-package
**Runtime dependencies.** qt5-or-qt6, ffmpeg
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later
**Executable (manifest canonical path).** `packages/2d-animation/pencil2d/active/bin/pencil2d`
**Launch.** `studioctl launch pencil2d` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id pencil2d`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
