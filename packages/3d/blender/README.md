# Blender

**ID:** `blender` | **Category:** 3D Modeling, Sculpting & Rendering
**Status:** not-tested | **Researched version:** 5.3.0 (upstream stable, 2026-11-10); 4.5.x LTS line available

3D modeling, animation, simulation, compositing and rendering

## Capabilities
- `3d-modeling`
- `sculpting`
- `uv-unwrapping`
- `texturing`
- `rigging`
- `animation`
- `geometry-nodes`
- `simulation`
- `compositing`
- `rendering`
- `grease-pencil`
- `motion-tracking`
- `camera-projection`
- `keying`
- `masking`
- `rotoscoping`
- `color-management`
- `particle-systems`
- `python-scripting`
- `video-editing`
- `2d-animation`

## Formats
blend, obj, fbx, glb, gltf, usd, stl, ply, abc, exr, png, mp4

## Dependencies
`libgl`, `libx11`, `libxkbcommon`, `libwayland`, `python3-embedded`, `ffmpeg-libs`

## Use
- `studioctl info blender --json`
- `studioctl launch blender --dry-run`
- `studioctl launch blender`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: GPL-3.0-or-later.

Official portable .tar.xz is preferred; it carries its own Python. Verify glibc baseline.

See `../../docs/applications/blender.md` (generated overview) and `metadata/`.
