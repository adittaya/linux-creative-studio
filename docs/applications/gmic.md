# G'MIC — application notes

**Purpose.** Image processing filter engine with CLI and GIMP/Krita plug-ins
**Suitable tasks.** Image processing filter engine with CLI and GIMP/Krita plug-ins
**Capabilities.** image-processing, filters, batch-processing, scripting, compositing
**Formats.** png, jpg, tif, exr, gmic
**Install methods.** distribution-package, flatpak, official-portable-archive, distribution-package, flatpak
**Runtime dependencies.** libjpeg, libpng, fftw, openmp
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** CECILL-2.1
**Executable (manifest canonical path).** `packages/2d-image/gmic/active/bin/gmic`
**Launch.** `studioctl launch gmic` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id gmic`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
