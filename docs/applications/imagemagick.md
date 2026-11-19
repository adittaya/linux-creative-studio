# ImageMagick — application notes

**Purpose.** Command-line image conversion, compositing and batch processing
**Suitable tasks.** Command-line image conversion, compositing and batch processing
**Capabilities.** image-conversion, batch-processing, image-processing, compositing, scripting, masking
**Formats.** png, jpg, tif, webp, gif, svg, pdf, exr, miff
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** libjpeg, libpng, libtiff, freetype, openmp
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** Apache-2.0
**Executable (manifest canonical path).** `packages/2d-image/imagemagick/active/bin/magick`
**Launch.** `studioctl launch imagemagick` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id imagemagick`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
