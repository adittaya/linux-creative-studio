# OpenShot — application notes

**Purpose.** Beginner-friendly timeline video editor
**Suitable tasks.** Beginner-friendly timeline video editor
**Capabilities.** video-editing, multitrack-editing, motion-graphics, keyframe-animation
**Formats.** osp, mp4, mov, mkv, webm, svg
**Install methods.** official-appimage, flatpak, distribution-package
**Runtime dependencies.** qt5, python3, mlt, ffmpeg
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-3.0-or-later
**Executable (manifest canonical path).** `packages/video/openshot/active/bin/openshot-qt`
**Launch.** `studioctl launch openshot` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id openshot`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
