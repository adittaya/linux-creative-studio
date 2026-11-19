# Audacity

**ID:** `audacity` | **Category:** Audio Production
**Status:** not-tested | **Researched version:** verify-upstream-at-download-time

Multitrack audio recording, editing and effects

## Capabilities
- `audio-editing`
- `audio-recording`
- `audio-effects`
- `batch-processing`
- `noise-reduction`

## Formats
wav, flac, mp3, ogg, aup3, aiff

## Dependencies
`wxwidgets`, `portaudio`, `ffmpeg-libs`, `ladspa`, `lv2`

## Use
- `studioctl info audacity --json`
- `studioctl launch audacity --dry-run`
- `studioctl launch audacity`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: GPL-2.0-or-later.

No extra caveats recorded.

See `../../docs/applications/audacity.md` (generated overview) and `metadata/`.
