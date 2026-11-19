# VLC — application notes

**Purpose.** Media playback and basic conversion/streaming
**Suitable tasks.** Media playback and basic conversion/streaming
**Capabilities.** media-playback, media-conversion, streaming, codec-validation
**Formats.** mp4, mkv, avi, mov, webm, mp3, flac, iso, dvd
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** qt5, libavcodec, alsa-or-pipewire
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later
**Executable (manifest canonical path).** `packages/media-infrastructure/vlc/active/bin/vlc`
**Launch.** `studioctl launch vlc` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id vlc`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
