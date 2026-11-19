# darktable — application notes

**Purpose.** Non-destructive RAW development and photo library
**Suitable tasks.** Non-destructive RAW development and photo library
**Capabilities.** raw-development, photo-editing, color-management, batch-processing, lens-correction, scene-referred-workflow
**Formats.** raw, dng, nef, cr2, arw, jpg, tif, xmp
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** gtk3, lensfun, openexr, opencolorio, libraw
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-3.0-or-later
**Executable (manifest canonical path).** `packages/2d-image/darktable/active/bin/darktable`
**Launch.** `studioctl launch darktable` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id darktable`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
