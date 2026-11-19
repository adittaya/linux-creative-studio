# Chromium (Remotion runtime)

**ID:** `chromium` | **Category:** Motion Graphics & Programmatic Video
**Status:** not-tested | **Researched version:** verify-upstream-at-download-time

Headless browser used by Remotion Renderer

## Capabilities
- `browser-runtime`
- `programmatic-video`
- `headless-rendering`
- `web-animation`

## Formats
html, js, webm, mp4

## Dependencies
`libnss3`, `libatk`, `libgbm`, `libasound2`, `fonts`

## Use
- `studioctl info chromium --json`
- `studioctl launch chromium --dry-run`
- `studioctl launch chromium`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: BSD-3-Clause and third-party.

Remotion downloads a pinned Chrome Headless Shell. Cache it explicitly with `npx remotion browser ensure` on a connected preparation machine.

See `../../docs/applications/chromium.md` (generated overview) and `metadata/`.
