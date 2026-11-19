# Lottie Tooling — application notes

**Purpose.** JSON animation export/import and preview tooling
**Suitable tasks.** JSON animation export/import and preview tooling
**Capabilities.** lottie, vector-animation, motion-graphics, svg-animation, json-animation
**Formats.** json, lottie, svg, gif, mp4
**Install methods.** npm-local-cache, glaxnimate-export
**Runtime dependencies.** nodejs-lts, glaxnimate
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** MIT-or-see-component
**Executable (manifest canonical path).** `packages/motion/lottie/active/bin/lottie-tools`
**Launch.** `studioctl launch lottie` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id lottie`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
