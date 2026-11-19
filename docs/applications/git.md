# Git — application notes

**Purpose.** Version control for projects, presets and scripts
**Suitable tasks.** Version control for projects, presets and scripts
**Capabilities.** version-control, automation, scripting
**Formats.** git, bundle, patch
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** curl-or-openssl, zlib
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later
**Executable (manifest canonical path).** `packages/media-infrastructure/git/active/bin/git`
**Launch.** `studioctl launch git` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id git`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
