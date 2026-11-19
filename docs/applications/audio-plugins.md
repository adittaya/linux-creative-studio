# Audio Plugin Collection — application notes

**Purpose.** Curated open-source LADSPA/LV2 plugin sets (LSP, Calf, x42)
**Suitable tasks.** Curated open-source LADSPA/LV2 plugin sets (LSP, Calf, x42)
**Capabilities.** audio-effects, audio-mixing, lv2, ladspa, equalization, dynamics, reverb
**Formats.** lv2, so, ttl, wav
**Install methods.** distribution-package, source-build
**Runtime dependencies.** lv2-host, ladspa-host, fftw
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later / LGPL / see each plugin
**Executable (manifest canonical path).** `packages/audio/audio-plugins/README.md`
**Launch.** `studioctl launch audio-plugins` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id audio-plugins`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
Install components individually; record each plugin's own license and version.
