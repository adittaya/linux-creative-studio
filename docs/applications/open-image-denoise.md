# Open Image Denoise — application notes

**Purpose.** Intel OIDN denoising library and CLI for path-traced renders
**Suitable tasks.** Intel OIDN denoising library and CLI for path-traced renders
**Capabilities.** denoising, rendering, batch-processing
**Formats.** exr, hdr, pfm, png
**Install methods.** portable-archive, distribution-package, source-build
**Runtime dependencies.** oneapi-tbb, ispc-runtime
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** Apache-2.0
**Executable (manifest canonical path).** `packages/3d/open-image-denoise/active/bin/oidnDenoise`
**Launch.** `studioctl launch open-image-denoise` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id open-image-denoise`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
