# Krita — application notes

**Purpose.** Digital painting, illustration and frame animation
**Suitable tasks.** Digital painting, illustration and frame animation
**Capabilities.** digital-painting, illustration, brush-engine, raster-editing, animation, masking, color-management, python-scripting
**Formats.** kra, ora, png, psd, tif, svg, webp, mp4
**Install methods.** official-appimage, flatpak, distribution-package
**Runtime dependencies.** qt5-or-qt6, kis-library, opencolorio, fontconfig
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-3.0-or-later
**Executable (manifest canonical path).** `packages/2d-image/krita/active/bin/krita`
**Launch.** `studioctl launch krita` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id krita`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
