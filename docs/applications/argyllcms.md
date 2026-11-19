# Argyll CMS — application notes

**Purpose.** Display and printer profiling, calibration and measurement tools
**Suitable tasks.** Display and printer profiling, calibration and measurement tools
**Capabilities.** display-calibration, icc-profiles, color-management, hardware-profiling
**Formats.** icc, icm, ti3, cal, cgats
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** libjpeg, libtiff, libusb-for-probes
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** AGPL-3.0-or-later
**Executable (manifest canonical path).** `packages/color/argyllcms/active/bin/colprof`
**Launch.** `studioctl launch argyllcms` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id argyllcms`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
