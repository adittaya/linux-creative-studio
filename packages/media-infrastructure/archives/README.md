# Archives & Compression Tools

**ID:** `archives` | **Category:** Media Infrastructure & Utilities
**Status:** not-tested | **Researched version:** verify-upstream-at-download-time

7-Zip/p7zip and standard archive utilities

## Capabilities
- `archiving`
- `extraction`
- `batch-processing`
- `scripting`

## Formats
7z, zip, tar, gz, xz, zst, rar

## Dependencies
`xz-libs`, `zstd-libs`

## Use
- `studioctl info archives --json`
- `studioctl launch archives --dry-run`
- `studioctl launch archives`

## Offline / licensing
Offline capable: **True**; network required for install: **False**;
online activation: **False**; license: LGPL-2.1-or-later / BSD / see component.

Prefer p7zip/7zip from trusted distribution repositories.

See `../../docs/applications/archives.md` (generated overview) and `metadata/`.
