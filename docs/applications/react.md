# React — application notes

**Purpose.** Component library used by Remotion compositions
**Suitable tasks.** Component library used by Remotion compositions
**Capabilities.** react, programmatic-video, motion-graphics, component-authoring
**Formats.** jsx, tsx, js, json
**Install methods.** npm-local-cache, distribution-package
**Runtime dependencies.** nodejs-lts, react-dom
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** MIT
**Executable (manifest canonical path).** `packages/motion/remotion/active/node_modules/react`
**Launch.** `studioctl launch react` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id react`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
