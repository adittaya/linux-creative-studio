# Blender — application notes

**Purpose.** 3D modeling, animation, simulation, compositing and rendering
**Suitable tasks.** 3D modeling, animation, simulation, compositing and rendering
**Capabilities.** 3d-modeling, sculpting, uv-unwrapping, texturing, rigging, animation, geometry-nodes, simulation, compositing, rendering, grease-pencil, motion-tracking, camera-projection, keying, masking, rotoscoping, color-management, particle-systems, python-scripting, video-editing, 2d-animation
**Formats.** blend, obj, fbx, glb, gltf, usd, stl, ply, abc, exr, png, mp4
**Install methods.** official-portable-archive, distribution-package, flatpak
**Runtime dependencies.** libgl, libx11, libxkbcommon, libwayland, python3-embedded, ffmpeg-libs
**Hardware.** 64-bit CPU, 8 GB RAM minimum (16 GB+ recommended); OpenGL 4.3+ / Vulkan for GPU viewport
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-3.0-or-later
**Executable (manifest canonical path).** `packages/3d/blender/active/bin/blender`
**Launch.** `studioctl launch blender` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id blender`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
Official portable .tar.xz is preferred; it carries its own Python. Verify glibc baseline.
