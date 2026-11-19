# Meshroom — application notes

**Purpose.** Photogrammetry pipeline for image-based 3D reconstruction
**Suitable tasks.** Photogrammetry pipeline for image-based 3D reconstruction
**Capabilities.** photogrammetry, 3d-scanning, mesh-processing, texture-generation
**Formats.** jpeg, png, obj, ply, fbx, gltf
**Install methods.** official-portable-archive, source-build
**Runtime dependencies.** qt5, opencv, cuda-or-cpu, openmvs, alicevision
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** MPL-2.0
**Executable (manifest canonical path).** `packages/3d/meshroom/active/bin/meshroom`
**Launch.** `studioctl launch meshroom` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id meshroom`
**Verification status.** `unavailable`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
Official Linux builds are version-specific and GPU (CUDA) oriented; verify before acquisition.
