# Audacity — application notes

**Purpose.** Multitrack audio recording, editing and effects
**Suitable tasks.** Multitrack audio recording, editing and effects
**Capabilities.** audio-editing, audio-recording, audio-effects, batch-processing, noise-reduction
**Formats.** wav, flac, mp3, ogg, aup3, aiff
**Install methods.** official-appimage, flatpak, distribution-package
**Runtime dependencies.** wxwidgets, portaudio, ffmpeg-libs, ladspa, lv2
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later
**Executable (manifest canonical path).** `packages/audio/audacity/active/bin/audacity`
**Launch.** `studioctl launch audacity` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id audacity`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
