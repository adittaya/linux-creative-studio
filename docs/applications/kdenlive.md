# Kdenlive — application notes

**Purpose.** Multitrack video editing with proxy workflow and color tools
**Suitable tasks.** Multitrack video editing with proxy workflow and color tools
**Capabilities.** video-editing, multitrack-editing, color-grading, motion-graphics, keying, compositing, proxy-workflow
**Formats.** kdenlive, mlt, xml, mp4, mov, mkv, webm
**Install methods.** distribution-package, flatpak, official-appimage, flatpak, distribution-package, flatpak
**Runtime dependencies.** mlt, ffmpeg, qt5-or-qt6, kf5, frei0r, ladspa
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-3.0-or-later
**Executable (manifest canonical path).** `packages/video/kdenlive/active/bin/kdenlive`
**Launch.** `studioctl launch kdenlive` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id kdenlive`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
