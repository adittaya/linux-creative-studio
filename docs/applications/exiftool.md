# ExifTool — application notes

**Purpose.** Read, write and edit metadata in images, video and audio
**Suitable tasks.** Read, write and edit metadata in images, video and audio
**Capabilities.** metadata, batch-processing, scripting, forensics
**Formats.** jpg, tif, png, raw, mp4, mov, pdf, xmp
**Install methods.** distribution-package, portable-archive
**Runtime dependencies.** perl5
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** Artistic-1.0-Perl OR GPL-1.0-or-later
**Executable (manifest canonical path).** `packages/2d-image/exiftool/active/bin/exiftool`
**Launch.** `studioctl launch exiftool` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id exiftool`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
