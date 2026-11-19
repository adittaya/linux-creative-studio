# LUT Collection — application notes

**Purpose.** Curated, license-cleared LUT and color transform library
**Suitable tasks.** Curated, license-cleared LUT and color transform library
**Capabilities.** color-grading, lut-processing, color-management, looks
**Formats.** cube, 3dl, look, ocio, ams
**Install methods.** configuration-data
**Runtime dependencies.** opencolorio
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** varies-per-item-see-licenses
**Executable (manifest canonical path).** `assets/luts/README.md`
**Launch.** `studioctl launch luts` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id luts`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
Repository ships only license-cleared items; each asset records source and license.
