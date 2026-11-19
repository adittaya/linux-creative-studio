# VFX Utilities

**ID:** `vfx-utilities` | **Category:** 2.5D & Visual Effects
**Status:** not-tested | **Researched version:** verify-upstream-at-download-time

Supporting CLI utilities for film-style pipelines

## Capabilities
- `image-sequence`
- `frame-conversion`
- `dpx-handling`
- `scripting`
- `timecode`
- `batch-processing`

## Formats
exr, dpx, png, mov

## Dependencies
`ffmpeg`, `python3`, `imagemagick`

## Use
- `studioctl info vfx-utilities --json`
- `studioctl launch vfx-utilities --dry-run`
- `studioctl launch vfx-utilities`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: varies-by-component.

Thin adapter bundle: no redistributed binaries; delegates to recorded system tools.

See `../../docs/applications/vfx-utilities.md` (generated overview) and `metadata/`.
