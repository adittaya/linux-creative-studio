# Natron

**ID:** `natron` | **Category:** 2.5D & Visual Effects
**Status:** not-tested | **Researched version:** verify-upstream-at-download-time

Node-based compositing, keying, tracking and color operations

## Capabilities
- `node-compositing`
- `keying`
- `motion-tracking`
- `rotoscoping`
- `masking`
- `color-grading`
- `multi-layer-compositing`
- `2.5d-animation`
- `vfx`
- `planar-tracking`

## Formats
ntp, exr, png, dpx, mov, mp4, abc, ocio-config

## Dependencies
`qt5`, `boost`, `ffmpeg`, `opencolorio`, `openexr`, `opencv`

## Use
- `studioctl info natron --json`
- `studioctl launch natron --dry-run`
- `studioctl launch natron`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: GPL-2.0-or-later.

Pin to an official release that matches bundled OpenColorIO configuration.

See `../../docs/applications/natron.md` (generated overview) and `metadata/`.
