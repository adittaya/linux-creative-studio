# Node.js LTS — application notes

**Purpose.** Local JavaScript runtime for Remotion and tooling
**Suitable tasks.** Local JavaScript runtime for Remotion and tooling
**Capabilities.** javascript-runtime, programmatic-video, scripting, npm
**Formats.** js, mjs, cjs, json, tar.xz
**Install methods.** official-portable-archive, distribution-package
**Runtime dependencies.** glibc, ca-certificates
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** MIT
**Executable (manifest canonical path).** `packages/motion/nodejs/active/bin/node`
**Launch.** `studioctl launch nodejs` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id nodejs`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
Pin an active LTS line at preparation time; store the official .tar.xz and its SHASUMS.
