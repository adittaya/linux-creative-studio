# VLC

**ID:** `vlc` | **Category:** Media Infrastructure & Utilities
**Status:** not-tested | **Researched version:** verify-upstream-at-download-time

Media playback and basic conversion/streaming

## Capabilities
- `media-playback`
- `media-conversion`
- `streaming`
- `codec-validation`

## Formats
mp4, mkv, avi, mov, webm, mp3, flac, iso, dvd

## Dependencies
`qt5`, `libavcodec`, `alsa-or-pipewire`

## Use
- `studioctl info vlc --json`
- `studioctl launch vlc --dry-run`
- `studioctl launch vlc`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: GPL-2.0-or-later.

No extra caveats recorded.

See `../../docs/applications/vlc.md` (generated overview) and `metadata/`.
