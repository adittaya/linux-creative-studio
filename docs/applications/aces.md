# ACES Configurations — application notes

**Purpose.** Academy Color Encoding System config files and references
**Suitable tasks.** Academy Color Encoding System config files and references
**Capabilities.** aces, color-management, color-transform, hdr-grading
**Formats.** ocio, cube, ctle, json
**Install methods.** configuration-data
**Runtime dependencies.** opencolorio
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** Apache-2.0 (config) / see upstream
**Executable (manifest canonical path).** `packages/color/aces/active/bin/aces-config-info`
**Launch.** `studioctl launch aces` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id aces`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
