# Blender Compositor — application notes

**Purpose.** Blender's node compositor for multi-layer VFX and color work
**Suitable tasks.** Blender's node compositor for multi-layer VFX and color work
**Capabilities.** node-compositing, multi-layer-compositing, keying, masking, motion-tracking, camera-projection, 2.5d-animation, color-management, compositing
**Formats.** blend, exr, png, dpx, mov
**Install methods.** capability facet only
**Runtime dependencies.** blender
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-3.0-or-later
**Executable (manifest canonical path).** `packages/3d/blender/active/bin/blender`
**Launch.** `studioctl launch blender-compositor` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id blender-compositor`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
Capability facet of Blender. Launch with `studioctl launch blender`.
