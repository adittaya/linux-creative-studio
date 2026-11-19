# GIMP — application notes

**Purpose.** Raster image editing, retouching, masking and graphic design
**Suitable tasks.** Raster image editing, retouching, masking and graphic design
**Capabilities.** raster-editing, photo-editing, background-removal, masking, layered-editing, color-correction, scripting
**Formats.** xcf, png, jpg, tif, psd, svg, webp, pdf, gif
**Install methods.** official-appimage, flatpak, distribution-package
**Runtime dependencies.** gtk3-or-gtk4, gegl, babl, fontconfig
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-3.0-or-later
**Executable (manifest canonical path).** `packages/2d-image/gimp/active/bin/gimp`
**Launch.** `studioctl launch gimp` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id gimp`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
