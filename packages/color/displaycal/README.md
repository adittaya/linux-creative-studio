# DisplayCAL

**ID:** `displaycal` | **Category:** Color Grading & Management
**Status:** unavailable | **Researched version:** verify-upstream-at-download-time

Display calibration and profiling front-end for Argyll CMS

## Capabilities
- `display-calibration`
- `icc-profiles`
- `color-management`

## Formats
icc, ti3, cal, png

## Dependencies
`python3`, `wxpython`, `argyllcms`, `numpy`

## Use
- `studioctl info displaycal --json`
- `studioctl launch displaycal --dry-run`
- `studioctl launch displaycal`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: GPL-3.0-or-later.

Upstream development is dormant; prefer Argyll CMS CLI plus current distro display-calibration tools.

See `../../docs/applications/displaycal.md` (generated overview) and `metadata/`.
