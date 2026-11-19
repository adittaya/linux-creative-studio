# Scribus — application notes

**Purpose.** Desktop publishing and print-ready page layout
**Suitable tasks.** Desktop publishing and print-ready page layout
**Capabilities.** page-layout, typography, print-production, pdf-export, color-management
**Formats.** sla, pdf, ps, eps, svg, png, idml
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** qt5, cups, fontconfig, icc-profiles
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later
**Executable (manifest canonical path).** `packages/2d-image/scribus/active/bin/scribus`
**Launch.** `studioctl launch scribus` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id scribus`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
