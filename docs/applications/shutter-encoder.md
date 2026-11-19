# Shutter Encoder — application notes

**Purpose.** FFmpeg-based conversion front-end with broadcast presets
**Suitable tasks.** FFmpeg-based conversion front-end with broadcast presets
**Capabilities.** video-transcoding, batch-processing, encoding-presets, media-conversion, color-management
**Formats.** mp4, mov, mkv, mxf, prores, dnxhd, wav
**Install methods.** official-portable-archive, distribution-package, flatpak
**Runtime dependencies.** java-or-native-bundle, ffmpeg
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** see-upstream-license
**Executable (manifest canonical path).** `packages/video/shutter-encoder/active/bin/shutter-encoder`
**Launch.** `studioctl launch shutter-encoder` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id shutter-encoder`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
