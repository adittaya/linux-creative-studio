# FFprobe

**ID:** `ffprobe` | **Category:** Media Infrastructure & Utilities
**Status:** not-tested | **Researched version:** verify-upstream-at-download-time

Inspect media streams, codecs, timing and metadata

## Capabilities
- `media-inspection`
- `validation`
- `metadata`
- `scripting`
- `ffprobe`

## Formats
mp4, mkv, mov, webm, wav, png, exr

## Dependencies
`ffmpeg-libs`

## Use
- `studioctl info ffprobe --json`
- `studioctl launch ffprobe --dry-run`
- `studioctl launch ffprobe`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: LGPL-2.1-or-later / GPL-2.0-or-later depending on build.

Capability facet of FFmpeg; shipped with the same build.

See `../../docs/applications/ffprobe.md` (generated overview) and `metadata/`.
