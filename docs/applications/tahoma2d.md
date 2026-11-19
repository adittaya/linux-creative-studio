# Tahoma2D — application notes

**Purpose.** 2D frame-by-frame and cut-out animation (OpenToonz fork)
**Suitable tasks.** 2D frame-by-frame and cut-out animation (OpenToonz fork)
**Capabilities.** 2d-animation, frame-by-frame, cutout-animation, puppet-animation, onion-skin, compositing
**Formats.** tnz, png, psd, flv, mp4, mov
**Install methods.** official-portable-archive, distribution-package, flatpak
**Runtime dependencies.** qt5, boost, ffmpeg, glew, opengl
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** BSD-3-Clause
**Executable (manifest canonical path).** `packages/2d-animation/tahoma2d/active/bin/tahoma2d`
**Launch.** `studioctl launch tahoma2d` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id tahoma2d`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
Upstream Linux builds primarily x86_64; verify ARM64 availability.
