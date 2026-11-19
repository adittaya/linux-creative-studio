# LosslessCut — application notes

**Purpose.** Fast stream-copy trimming and remuxing of video/audio
**Suitable tasks.** Fast stream-copy trimming and remuxing of video/audio
**Capabilities.** lossless-cut, video-trimming, remuxing, batch-processing
**Formats.** mp4, mov, mkv, ts, m4a, webm
**Install methods.** official-appimage, flatpak, distribution-package
**Runtime dependencies.** electron-runtime, ffmpeg
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-3.0-or-later
**Executable (manifest canonical path).** `packages/video/losslesscut/active/bin/lossless-cut`
**Launch.** `studioctl launch losslesscut` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id losslesscut`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
AppImage bundles Electron; verify sandbox/GPU options on target host.
