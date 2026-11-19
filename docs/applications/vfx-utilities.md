# VFX Utilities — application notes

**Purpose.** Supporting CLI utilities for film-style pipelines
**Suitable tasks.** Supporting CLI utilities for film-style pipelines
**Capabilities.** image-sequence, frame-conversion, dpx-handling, scripting, timecode, batch-processing
**Formats.** exr, dpx, png, mov
**Install methods.** distribution-package
**Runtime dependencies.** ffmpeg, python3, imagemagick
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** varies-by-component
**Executable (manifest canonical path).** `scripts/vfx-utilities.sh`
**Launch.** `studioctl launch vfx-utilities` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id vfx-utilities`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
Thin adapter bundle: no redistributed binaries; delegates to recorded system tools.
