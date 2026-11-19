# Blender Color Management — application notes

**Purpose.** Blender OCIO/AGX/Filmic view transforms
**Suitable tasks.** Blender OCIO/AGX/Filmic view transforms
**Capabilities.** color-management, color-grading, hdr-grading, scene-referred-workflow
**Formats.** blend, exr, ocio
**Install methods.** capability facet only
**Runtime dependencies.** blender, opencolorio
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-3.0-or-later
**Executable (manifest canonical path).** `packages/3d/blender/active/bin/blender`
**Launch.** `studioctl launch blender-color-management` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id blender-color-management`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
