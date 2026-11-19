# PipeWire

**ID:** `pipewire` | **Category:** Audio Production
**Status:** not-tested | **Researched version:** verify-upstream-at-download-time

Modern low-latency audio/video server with JACK and ALSA compatibility

## Capabilities
- `audio-server`
- `audio-routing`
- `audio-recording`
- `low-latency-audio`

## Formats
conf, wav

## Dependencies
`dbus`, `alsa-lib`, `wireplumber`

## Use
- `studioctl info pipewire --json`
- `studioctl launch pipewire --dry-run`
- `studioctl launch pipewire`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: MIT and LGPL-2.1-or-later.

No extra caveats recorded.

See `../../docs/applications/pipewire.md` (generated overview) and `metadata/`.
