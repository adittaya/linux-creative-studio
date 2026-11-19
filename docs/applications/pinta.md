# Pinta — application notes

**Purpose.** Simple GTK raster image editor inspired by Paint.NET
**Suitable tasks.** Simple GTK raster image editor inspired by Paint.NET
**Capabilities.** raster-editing, photo-editing, layered-editing
**Formats.** png, jpg, tif, bmp, ora, pdn
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** gtk3, cairo, mono-or-dotnet
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-3.0-or-later
**Executable (manifest canonical path).** `packages/2d-image/pinta/active/bin/pinta`
**Launch.** `studioctl launch pinta` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id pinta`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
