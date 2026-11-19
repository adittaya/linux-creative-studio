# MLT Framework — application notes

**Purpose.** Multitrack media framework used by Kdenlive, Shotcut and others
**Suitable tasks.** Multitrack media framework used by Kdenlive, Shotcut and others
**Capabilities.** video-framework, video-editing, compositing, scripting, encoding
**Formats.** mlt, xml, mp4, mov, mkv
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** ffmpeg, frei0r, ladspa, sdl2-or-qt
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** LGPL-2.1-or-later
**Executable (manifest canonical path).** `packages/video/mlt/active/bin/melt`
**Launch.** `studioctl launch mlt` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id mlt`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
