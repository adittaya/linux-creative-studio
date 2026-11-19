# Shotcut — application notes

**Purpose.** Cross-platform video editor built on the MLT framework
**Suitable tasks.** Cross-platform video editor built on the MLT framework
**Capabilities.** video-editing, multitrack-editing, color-grading, keying, compositing, screen-recording
**Formats.** mlt, xml, mp4, mov, mkv, webm, m2ts
**Install methods.** official-appimage, flatpak, distribution-package
**Runtime dependencies.** qt5, mlt, ffmpeg, frei0r, ladspa
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-3.0-or-later
**Executable (manifest canonical path).** `packages/video/shotcut/active/bin/shotcut`
**Launch.** `studioctl launch shotcut` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id shotcut`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
