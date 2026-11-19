# Flowblade — application notes

**Purpose.** Film-style multitrack editor with precise trimming tools
**Suitable tasks.** Film-style multitrack editor with precise trimming tools
**Capabilities.** video-editing, multitrack-editing, keyframe-animation, proxy-workflow
**Formats.** mlt, xml, mp4, mov, mkv
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** mlt, ffmpeg, gtk3, python3
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-3.0-or-later
**Executable (manifest canonical path).** `packages/video/flowblade/active/bin/flowblade`
**Launch.** `studioctl launch flowblade` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id flowblade`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
