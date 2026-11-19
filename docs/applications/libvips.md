# libvips — application notes

**Purpose.** Low-memory high-performance image processing library and CLI
**Suitable tasks.** Low-memory high-performance image processing library and CLI
**Capabilities.** image-processing, image-conversion, batch-processing, thumbnail-generation
**Formats.** vips, png, jpg, webp, tif, exr, heif, svg
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** glib2, libjpeg, libpng, libtiff, lcms2
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** LGPL-2.1-or-later
**Executable (manifest canonical path).** `packages/2d-image/libvips/active/bin/vips`
**Launch.** `studioctl launch libvips` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id libvips`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
