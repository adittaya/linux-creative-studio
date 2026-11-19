# Audio Plugin Collection

**ID:** `audio-plugins` | **Category:** Audio Production
**Status:** not-tested | **Researched version:** verify-upstream-at-download-time

Curated open-source LADSPA/LV2 plugin sets (LSP, Calf, x42)

## Capabilities
- `audio-effects`
- `audio-mixing`
- `lv2`
- `ladspa`
- `equalization`
- `dynamics`
- `reverb`

## Formats
lv2, so, ttl, wav

## Dependencies
`lv2-host`, `ladspa-host`, `fftw`

## Use
- `studioctl info audio-plugins --json`
- `studioctl launch audio-plugins --dry-run`
- `studioctl launch audio-plugins`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: GPL-2.0-or-later / LGPL / see each plugin.

Install components individually; record each plugin's own license and version.

See `../../docs/applications/audio-plugins.md` (generated overview) and `metadata/`.
