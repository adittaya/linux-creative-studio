# Ardour

**ID:** `ardour` | **Category:** Audio Production
**Status:** not-tested | **Researched version:** verify-upstream-at-download-time

Professional DAW for recording, mixing and mastering

## Capabilities
- `daw`
- `audio-recording`
- `audio-mixing`
- `audio-effects`
- `midi`
- `automation`

## Formats
ard, wav, aiff, flac, mid, lv2

## Dependencies
`gtk3`, `jack-or-pipewire`, `lv2`, `ladspa`, `vst3-host`

## Use
- `studioctl info ardour --json`
- `studioctl launch ardour --dry-run`
- `studioctl launch ardour`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: GPL-2.0-or-later.

No extra caveats recorded.

See `../../docs/applications/ardour.md` (generated overview) and `metadata/`.
