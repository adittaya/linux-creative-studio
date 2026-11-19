# Archives & Compression Tools — application notes

**Purpose.** 7-Zip/p7zip and standard archive utilities
**Suitable tasks.** 7-Zip/p7zip and standard archive utilities
**Capabilities.** archiving, extraction, batch-processing, scripting
**Formats.** 7z, zip, tar, gz, xz, zst, rar
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** xz-libs, zstd-libs
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** LGPL-2.1-or-later / BSD / see component
**Executable (manifest canonical path).** `packages/media-infrastructure/archives/active/bin/7z`
**Launch.** `studioctl launch archives` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id archives`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
Prefer p7zip/7zip from trusted distribution repositories.
