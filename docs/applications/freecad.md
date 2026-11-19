# FreeCAD — application notes

**Purpose.** Parametric CAD modeling, engineering and mesh workbenches
**Suitable tasks.** Parametric CAD modeling, engineering and mesh workbenches
**Capabilities.** cad-modeling, parametric-modeling, 3d-modeling, cad-export, python-scripting
**Formats.** fcstd, step, stp, iges, stl, obj, dxf, svg
**Install methods.** distribution-package, flatpak, official-appimage, flatpak, distribution-package
**Runtime dependencies.** qt5, coin3d, occ, python3, vtk
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** LGPL-2.0-or-later
**Executable (manifest canonical path).** `packages/3d/freecad/active/bin/freecad`
**Launch.** `studioctl launch freecad` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id freecad`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
