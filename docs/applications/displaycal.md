# DisplayCAL — application notes

**Purpose.** Display calibration and profiling front-end for Argyll CMS
**Suitable tasks.** Display calibration and profiling front-end for Argyll CMS
**Capabilities.** display-calibration, icc-profiles, color-management
**Formats.** icc, ti3, cal, png
**Install methods.** distribution-package, python-wheel, source-build
**Runtime dependencies.** python3, wxpython, argyllcms, numpy
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-3.0-or-later
**Executable (manifest canonical path).** `packages/color/displaycal/active/bin/displaycal`
**Launch.** `studioctl launch displaycal` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id displaycal`
**Verification status.** `unavailable`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
Upstream development is dormant; prefer Argyll CMS CLI plus current distro display-calibration tools.
