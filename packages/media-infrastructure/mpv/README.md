# mpv

**ID:** `mpv` | **Category:** Media Infrastructure & Utilities
**Status:** not-tested | **Researched version:** verify-upstream-at-download-time

Lightweight scriptable media player for review and QC

## Capabilities
- `media-playback`
- `color-management`
- `qc`
- `scripting`

## Formats
mp4, mkv, mov, webm, avi, exr, png

## Dependencies
`libavcodec`, `libplacebo`, `opengl`, `alsa-or-pipewire`

## Use
- `studioctl info mpv --json`
- `studioctl launch mpv --dry-run`
- `studioctl launch mpv`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: GPL-2.0-or-later.

No extra caveats recorded.

See `../../docs/applications/mpv.md` (generated overview) and `metadata/`.
