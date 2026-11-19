# LosslessCut

**ID:** `losslesscut` | **Category:** Video Editing
**Status:** not-tested | **Researched version:** verify-upstream-at-download-time

Fast stream-copy trimming and remuxing of video/audio

## Capabilities
- `lossless-cut`
- `video-trimming`
- `remuxing`
- `batch-processing`

## Formats
mp4, mov, mkv, ts, m4a, webm

## Dependencies
`electron-runtime`, `ffmpeg`

## Use
- `studioctl info losslesscut --json`
- `studioctl launch losslesscut --dry-run`
- `studioctl launch losslesscut`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: GPL-3.0-or-later.

AppImage bundles Electron; verify sandbox/GPU options on target host.

See `../../docs/applications/losslesscut.md` (generated overview) and `metadata/`.
