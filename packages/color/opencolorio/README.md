# OpenColorIO

**ID:** `opencolorio` | **Category:** Color Grading & Management
**Status:** not-tested | **Researched version:** verify-upstream-at-download-time

Color management configuration and transform library

## Capabilities
- `color-management`
- `color-transform`
- `lut-processing`
- `aces`
- `scripting`

## Formats
ocio, cube, 3dl, spi1d, spi3d, exr

## Dependencies
`yaml-cpp`, `half`, `pybind11-for-python-bindings`

## Use
- `studioctl info opencolorio --json`
- `studioctl launch opencolorio --dry-run`
- `studioctl launch opencolorio`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: BSD-3-Clause.

No extra caveats recorded.

See `../../docs/applications/opencolorio.md` (generated overview) and `metadata/`.
