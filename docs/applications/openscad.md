# OpenSCAD — application notes

**Purpose.** Script-based solid modeling for parametric and printable parts
**Suitable tasks.** Script-based solid modeling for parametric and printable parts
**Capabilities.** procedural-modeling, cad-modeling, 3d-printing, scripting
**Formats.** scad, stl, off, dxf, svg, amf, 3mf
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** qt5, cgal, opencsg, eigen3, boost
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later
**Executable (manifest canonical path).** `packages/3d/openscad/active/bin/openscad`
**Launch.** `studioctl launch openscad` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id openscad`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
