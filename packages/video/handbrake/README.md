# HandBrake

**ID:** `handbrake` | **Category:** Video Editing
**Status:** not-tested | **Researched version:** verify-upstream-at-download-time

Batch transcoding and compression presets for delivery

## Capabilities
- `video-transcoding`
- `batch-processing`
- `compression`
- `encoding-presets`

## Formats
mp4, mkv, webm, avi, iso, dvd

## Dependencies
`gtk3`, `ffmpeg-libs`, `x264`, `x265`, `libvpx`

## Use
- `studioctl info handbrake --json`
- `studioctl launch handbrake --dry-run`
- `studioctl launch handbrake`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: GPL-2.0-or-later.

HandBrake CLI may be distributed separately from the GUI in some channels.

See `../../docs/applications/handbrake.md` (generated overview) and `metadata/`.
