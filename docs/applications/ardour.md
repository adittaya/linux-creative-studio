# Ardour — application notes

**Purpose.** Professional DAW for recording, mixing and mastering
**Suitable tasks.** Professional DAW for recording, mixing and mastering
**Capabilities.** daw, audio-recording, audio-mixing, audio-effects, midi, automation
**Formats.** ard, wav, aiff, flac, mid, lv2
**Install methods.** distribution-package, flatpak, official-appimage, flatpak, distribution-package
**Runtime dependencies.** gtk3, jack-or-pipewire, lv2, ladspa, vst3-host
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later
**Executable (manifest canonical path).** `packages/audio/ardour/active/bin/ardour`
**Launch.** `studioctl launch ardour` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id ardour`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
