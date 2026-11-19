# Carla — application notes

**Purpose.** Plugin host and modular audio patchbay (LV2/LADSPA/VST)
**Suitable tasks.** Plugin host and modular audio patchbay (LV2/LADSPA/VST)
**Capabilities.** plugin-host, audio-routing, daw, modular-audio, lv2, ladspa
**Formats.** carxp, carxr, lv2, ladspa, vst, jack
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** qt5, jack-or-pipewire, alsa, lv2, ladspa
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later
**Executable (manifest canonical path).** `packages/audio/carla/active/bin/carla`
**Launch.** `studioctl launch carla` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id carla`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
