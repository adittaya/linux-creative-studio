# ALSA

**ID:** `alsa` | **Category:** Audio Production
**Status:** not-tested | **Researched version:** verify-upstream-at-download-time

Linux kernel audio interface and userspace utilities

## Capabilities
- `audio-server`
- `audio-device-management`
- `audio-routing`

## Formats
conf, wav

## Dependencies
`kernel-sound-stack`

## Use
- `studioctl info alsa --json`
- `studioctl launch alsa --dry-run`
- `studioctl launch alsa`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: GPL-2.0-or-later and LGPL-2.1-or-later.

No extra caveats recorded.

See `../../docs/applications/alsa.md` (generated overview) and `metadata/`.
