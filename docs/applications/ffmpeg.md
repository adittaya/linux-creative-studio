# FFmpeg — application notes

**Purpose.** Decode, encode, transcode, filter, stream and inspect media
**Suitable tasks.** Decode, encode, transcode, filter, stream and inspect media
**Capabilities.** media-conversion, video-transcoding, video-encoding, audio-encoding, image-sequence, filtering, scripting, ffprobe
**Formats.** mp4, mkv, mov, webm, avi, ts, mxf, prores, dnxhd, wav, flac, png, exr
**Install methods.** distribution-package, flatpak, official-static-build, portable-archive
**Runtime dependencies.** libx264, libx265, libvpx, libopus, freetype, fontconfig, zlib, lzma
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** LGPL-2.1-or-later / GPL-2.0-or-later depending on build
**Executable (manifest canonical path).** `packages/media-infrastructure/ffmpeg/active/bin/ffmpeg`
**Launch.** `studioctl launch ffmpeg` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id ffmpeg`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
Record configure flags and license of the exact build; GPL-enabled builds have redistribution consequences.
