# Natron — application notes

**Purpose.** Node-based compositing, keying, tracking and color operations
**Suitable tasks.** Node-based compositing, keying, tracking and color operations
**Capabilities.** node-compositing, keying, motion-tracking, rotoscoping, masking, color-grading, multi-layer-compositing, 2.5d-animation, vfx, planar-tracking
**Formats.** ntp, exr, png, dpx, mov, mp4, abc, ocio-config
**Install methods.** official-portable-archive, flatpak, source-build
**Runtime dependencies.** qt5, boost, ffmpeg, opencolorio, openexr, opencv
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later
**Executable (manifest canonical path).** `packages/2.5d-vfx/natron/active/bin/Natron`
**Launch.** `studioctl launch natron` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id natron`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
Pin to an official release that matches bundled OpenColorIO configuration.
