# DaVinci Resolve (optional)

**ID:** `davinci-resolve` | **Category:** Color Grading & Management
**Status:** not-redistributable | **Researched version:** verify-upstream-at-download-time

Proprietary professional NLE and color grading suite

## Capabilities
- `color-grading`
- `video-editing`
- `fairlight-audio`
- `fusion-vfx`
- `hdr-grading`

## Formats
drp, mp4, mov, exr, dpx, braw

## Dependencies
`proprietary-driver-stack`, `ffmpeg`, `opencl-or-cuda`

## Use
- `studioctl info davinci-resolve --json`
- `studioctl launch davinci-resolve --dry-run`
- `studioctl launch davinci-resolve`

## Offline / licensing
Offline capable: **False**; network required for install: **True**;
online activation: **True**; license: proprietary-redistribution-restricted.

Optional commercial package. Do NOT redistribute. Separate acquisition procedure in installers/optional-commercial/.

See `../../docs/applications/davinci-resolve.md` (generated overview) and `metadata/`.
