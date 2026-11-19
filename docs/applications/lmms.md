# LMMS — application notes

**Purpose.** Music production, sequencing and synthesis
**Suitable tasks.** Music production, sequencing and synthesis
**Capabilities.** music-production, daw, midi, synthesis, sequencing
**Formats.** mmp, mmpz, mid, wav, ogg, sf2
**Install methods.** distribution-package, flatpak, official-appimage, flatpak, distribution-package
**Runtime dependencies.** qt5, jack-or-pipewire, alsa, lv2, sf2
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later
**Executable (manifest canonical path).** `packages/audio/lmms/active/bin/lmms`
**Launch.** `studioctl launch lmms` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id lmms`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
