# OpenToonz — application notes

**Purpose.** Professional 2D animation and compositing system
**Suitable tasks.** Professional 2D animation and compositing system
**Capabilities.** 2d-animation, frame-by-frame, cutout-animation, compositing, motion-tracking, keying, camera-movement
**Formats.** tnz, png, psd, tif, mp4, mov
**Install methods.** official-portable-archive, distribution-package, flatpak
**Runtime dependencies.** qt5, boost, ffmpeg, glew, opengl
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** BSD-3-Clause
**Executable (manifest canonical path).** `packages/2d-animation/opentoonz/active/bin/opentoonz`
**Launch.** `studioctl launch opentoonz` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id opentoonz`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
