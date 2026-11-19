# SVG Animation Tools — application notes

**Purpose.** CLI utilities for optimizing and animating SVG assets
**Suitable tasks.** CLI utilities for optimizing and animating SVG assets
**Capabilities.** svg-animation, vector-animation, svg-optimization, motion-graphics
**Formats.** svg, smil, json, png
**Install methods.** npm-local-cache, distribution-package
**Runtime dependencies.** nodejs-lts, inkscape, python3
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** varies-by-component
**Executable (manifest canonical path).** `packages/motion/svg-tools/active/bin/svg-tools`
**Launch.** `studioctl launch svg-tools` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id svg-tools`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
