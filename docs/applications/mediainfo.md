# MediaInfo — application notes

**Purpose.** Detailed technical and tag information for media files
**Suitable tasks.** Detailed technical and tag information for media files
**Capabilities.** media-inspection, metadata, validation, scripting
**Formats.** mp4, mkv, mov, avi, mp3, flac, png
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** libzen, libmediainfo
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** BSD-2-Clause
**Executable (manifest canonical path).** `packages/media-infrastructure/mediainfo/active/bin/mediainfo`
**Launch.** `studioctl launch mediainfo` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id mediainfo`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
