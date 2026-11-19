# mpv — application notes

**Purpose.** Lightweight scriptable media player for review and QC
**Suitable tasks.** Lightweight scriptable media player for review and QC
**Capabilities.** media-playback, color-management, qc, scripting
**Formats.** mp4, mkv, mov, webm, avi, exr, png
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** libavcodec, libplacebo, opengl, alsa-or-pipewire
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later
**Executable (manifest canonical path).** `packages/media-infrastructure/mpv/active/bin/mpv`
**Launch.** `studioctl launch mpv` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id mpv`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
