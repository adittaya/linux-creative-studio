# Avidemux — application notes

**Purpose.** Simple linear video cutting, filtering and transcoding
**Suitable tasks.** Simple linear video cutting, filtering and transcoding
**Capabilities.** video-editing, lossless-cut, video-transcoding, batch-processing
**Formats.** mp4, mkv, avi, mov, mpeg, ts
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** qt5-or-gtk3, ffmpeg-libs
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later
**Executable (manifest canonical path).** `packages/video/avidemux/active/bin/avidemux`
**Launch.** `studioctl launch avidemux` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id avidemux`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
