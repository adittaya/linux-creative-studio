# TypeScript — application notes

**Purpose.** Typed superset of JavaScript for composition authoring
**Suitable tasks.** Typed superset of JavaScript for composition authoring
**Capabilities.** typescript, scripting, programmatic-video
**Formats.** ts, tsx, json
**Install methods.** npm-local-cache, distribution-package
**Runtime dependencies.** nodejs-lts
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** Apache-2.0
**Executable (manifest canonical path).** `packages/motion/remotion/active/node_modules/.bin/tsc`
**Launch.** `studioctl launch typescript` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id typescript`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
