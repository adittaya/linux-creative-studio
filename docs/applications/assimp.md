# Assimp — application notes

**Purpose.** Library and CLI for importing/exporting dozens of 3D asset formats
**Suitable tasks.** Library and CLI for importing/exporting dozens of 3D asset formats
**Capabilities.** 3d-format-conversion, mesh-processing, batch-processing, scripting
**Formats.** obj, fbx, gltf, glb, dae, stl, ply, 3ds, off
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** zlib, boost
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** BSD-3-Clause
**Executable (manifest canonical path).** `packages/3d/assimp/active/bin/assimp`
**Launch.** `studioctl launch assimp` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id assimp`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
