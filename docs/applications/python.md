# Python 3 — application notes

**Purpose.** Scripting runtime for pipeline automation and plug-ins
**Suitable tasks.** Scripting runtime for pipeline automation and plug-ins
**Capabilities.** scripting, automation, python, batch-processing
**Formats.** py, pyw, whl, tar.gz, json
**Install methods.** distribution-package, official-source-build
**Runtime dependencies.** glibc, openssl, zlib
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** Python-2.0
**Executable (manifest canonical path).** `packages/media-infrastructure/python/active/bin/python3`
**Launch.** `studioctl launch python` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id python`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
Use the system Python for system tooling; isolate project dependencies in venvs under runtimes/python/.
