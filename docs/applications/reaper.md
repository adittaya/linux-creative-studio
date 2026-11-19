# REAPER (optional) — application notes

**Purpose.** Proprietary DAW with low resource use and broad plugin support
**Suitable tasks.** Proprietary DAW with low resource use and broad plugin support
**Capabilities.** daw, audio-recording, audio-mixing, audio-effects, midi
**Formats.** rpp, wav, aiff, flac, mid, vst
**Install methods.** vendor-official-installer
**Runtime dependencies.** alsa, jack-or-pipewire, vst-plugins
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** No / restricted; install-time network: True; online activation: True
**License.** proprietary-redistribution-restricted
**Executable (manifest canonical path).** `packages/audio/reaper/active/bin/reaper`
**Launch.** `studioctl launch reaper` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id reaper`
**Verification status.** `not-redistributable`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
Optional commercial package. Evaluation license terms apply. Separate acquisition procedure only.
