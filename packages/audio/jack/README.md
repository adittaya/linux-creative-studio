# JACK Audio Connection Kit

**ID:** `jack` | **Category:** Audio Production
**Status:** not-tested | **Researched version:** verify-upstream-at-download-time

Low-latency audio routing for professional DAWs

## Capabilities
- `audio-server`
- `audio-routing`
- `low-latency-audio`

## Formats
conf, wav

## Dependencies
`alsa-lib`, `dbus`

## Use
- `studioctl info jack --json`
- `studioctl launch jack --dry-run`
- `studioctl launch jack`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: GPL-2.0-or-later and LGPL-2.1-or-later.

No extra caveats recorded.

See `../../docs/applications/jack.md` (generated overview) and `metadata/`.
