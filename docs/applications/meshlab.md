# MeshLab — application notes

**Purpose.** Mesh processing, cleaning, decimation and inspection
**Suitable tasks.** Mesh processing, cleaning, decimation and inspection
**Capabilities.** mesh-processing, mesh-cleanup, 3d-scanning, 3d-modeling, texture-baking
**Formats.** ply, stl, obj, off, ply, fbx, 3ds, las, e57
**Install methods.** distribution-package, flatpak, official-appimage, flatpak, distribution-package
**Runtime dependencies.** qt5, opengl, vcglib, qhull
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-3.0-or-later
**Executable (manifest canonical path).** `packages/3d/meshlab/active/bin/meshlab`
**Launch.** `studioctl launch meshlab` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id meshlab`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
