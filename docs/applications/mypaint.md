# MyPaint — application notes

**Purpose.** Brush-focused sketching and illustration with unlimited canvas
**Suitable tasks.** Brush-focused sketching and illustration with unlimited canvas
**Capabilities.** digital-painting, illustration, sketching, brush-engine
**Formats.** ora, png, psd, svg, jpg
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** gtk3, python3, numpy
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later
**Executable (manifest canonical path).** `packages/2d-image/mypaint/active/bin/mypaint`
**Launch.** `studioctl launch mypaint` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id mypaint`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
