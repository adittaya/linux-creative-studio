# Argyll CMS

**ID:** `argyllcms` | **Category:** Color Grading & Management
**Status:** not-tested | **Researched version:** verify-upstream-at-download-time

Display and printer profiling, calibration and measurement tools

## Capabilities
- `display-calibration`
- `icc-profiles`
- `color-management`
- `hardware-profiling`

## Formats
icc, icm, ti3, cal, cgats

## Dependencies
`libjpeg`, `libtiff`, `libusb-for-probes`

## Use
- `studioctl info argyllcms --json`
- `studioctl launch argyllcms --dry-run`
- `studioctl launch argyllcms`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: AGPL-3.0-or-later.

No extra caveats recorded.

See `../../docs/applications/argyllcms.md` (generated overview) and `metadata/`.
