# OpenColorIO — application notes

**Purpose.** Color management configuration and transform library
**Suitable tasks.** Color management configuration and transform library
**Capabilities.** color-management, color-transform, lut-processing, aces, scripting
**Formats.** ocio, cube, 3dl, spi1d, spi3d, exr
**Install methods.** distribution-package, flatpak, python-wheel, source-build
**Runtime dependencies.** yaml-cpp, half, pybind11-for-python-bindings
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** BSD-3-Clause
**Executable (manifest canonical path).** `packages/color/opencolorio/active/bin/ociobakelut`
**Launch.** `studioctl launch opencolorio` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id opencolorio`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
