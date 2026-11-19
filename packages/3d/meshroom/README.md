# Meshroom

**ID:** `meshroom` | **Category:** 3D Modeling, Sculpting & Rendering
**Status:** unavailable | **Researched version:** verify-upstream-at-download-time

Photogrammetry pipeline for image-based 3D reconstruction

## Capabilities
- `photogrammetry`
- `3d-scanning`
- `mesh-processing`
- `texture-generation`

## Formats
jpeg, png, obj, ply, fbx, gltf

## Dependencies
`qt5`, `opencv`, `cuda-or-cpu`, `openmvs`, `alicevision`

## Use
- `studioctl info meshroom --json`
- `studioctl launch meshroom --dry-run`
- `studioctl launch meshroom`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: MPL-2.0.

Official Linux builds are version-specific and GPU (CUDA) oriented; verify before acquisition.

See `../../docs/applications/meshroom.md` (generated overview) and `metadata/`.
