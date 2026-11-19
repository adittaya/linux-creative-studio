# FFprobe — application notes

**Purpose.** Inspect media streams, codecs, timing and metadata
**Suitable tasks.** Inspect media streams, codecs, timing and metadata
**Capabilities.** media-inspection, validation, metadata, scripting, ffprobe
**Formats.** mp4, mkv, mov, webm, wav, png, exr
**Install methods.** distribution-package, flatpak, official-static-build
**Runtime dependencies.** ffmpeg-libs
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** LGPL-2.1-or-later / GPL-2.0-or-later depending on build
**Executable (manifest canonical path).** `packages/media-infrastructure/ffmpeg/active/bin/ffprobe`
**Launch.** `studioctl launch ffprobe` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id ffprobe`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
Capability facet of FFmpeg; shipped with the same build.
