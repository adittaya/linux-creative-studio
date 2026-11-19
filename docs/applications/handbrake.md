# HandBrake — application notes

**Purpose.** Batch transcoding and compression presets for delivery
**Suitable tasks.** Batch transcoding and compression presets for delivery
**Capabilities.** video-transcoding, batch-processing, compression, encoding-presets
**Formats.** mp4, mkv, webm, avi, iso, dvd
**Install methods.** official-appimage, flatpak, distribution-package
**Runtime dependencies.** gtk3, ffmpeg-libs, x264, x265, libvpx
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later
**Executable (manifest canonical path).** `packages/video/handbrake/active/bin/handbrake`
**Launch.** `studioctl launch handbrake` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id handbrake`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
HandBrake CLI may be distributed separately from the GUI in some channels.
