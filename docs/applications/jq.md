# jq — application notes

**Purpose.** Command-line JSON processor for manifest and pipeline scripting
**Suitable tasks.** Command-line JSON processor for manifest and pipeline scripting
**Capabilities.** json-processing, automation, scripting
**Formats.** json, jsonl
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** oniguruma
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** MIT
**Executable (manifest canonical path).** `packages/media-infrastructure/jq/active/bin/jq`
**Launch.** `studioctl launch jq` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id jq`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
