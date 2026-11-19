# RawTherapee — application notes

**Purpose.** RAW photo development with fine-grained tone and color controls
**Suitable tasks.** RAW photo development with fine-grained tone and color controls
**Capabilities.** raw-development, photo-editing, color-correction, demosaicing, batch-processing, color-management
**Formats.** raw, dng, nef, cr2, arw, jpg, tif, pp3
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** gtk3, libraw, lcms2, exiv2
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-3.0-or-later
**Executable (manifest canonical path).** `packages/2d-image/rawtherapee/active/bin/rawtherapee`
**Launch.** `studioctl launch rawtherapee` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id rawtherapee`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
