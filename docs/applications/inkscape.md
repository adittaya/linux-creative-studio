# Inkscape — application notes

**Purpose.** SVG vector design, typography and icon authoring
**Suitable tasks.** SVG vector design, typography and icon authoring
**Capabilities.** vector-design, svg-editing, typography, illustration, svg-animation, pdf-export
**Formats.** svg, pdf, eps, png, dxf, ai, webp
**Install methods.** official-appimage, flatpak, distribution-package
**Runtime dependencies.** gtk3, cairo, pango
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later
**Executable (manifest canonical path).** `packages/2d-image/inkscape/active/bin/inkscape`
**Launch.** `studioctl launch inkscape` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id inkscape`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
