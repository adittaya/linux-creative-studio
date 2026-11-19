# GStreamer

**ID:** `gstreamer` | **Category:** Media Infrastructure & Utilities
**Status:** not-tested | **Researched version:** verify-upstream-at-download-time

Modular multimedia pipeline framework and plugins

## Capabilities
- `media-pipeline`
- `media-conversion`
- `streaming`
- `capture`
- `scripting`

## Formats
mp4, mkv, webm, wav, png, rtsp

## Dependencies
`glib2`, `plugin-base`, `plugin-good`, `plugin-bad`, `plugin-ugly`, `libav`

## Use
- `studioctl info gstreamer --json`
- `studioctl launch gstreamer --dry-run`
- `studioctl launch gstreamer`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: LGPL-2.1-or-later.

No extra caveats recorded.

See `../../docs/applications/gstreamer.md` (generated overview) and `metadata/`.
