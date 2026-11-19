# Synfig Studio — application notes

**Purpose.** Vector-based 2D animation with bones and tweening
**Suitable tasks.** Vector-based 2D animation with bones and tweening
**Capabilities.** 2d-animation, vector-animation, tweening, rigging-2d, cutout-animation, motion-graphics
**Formats.** sif, sifz, png, svg, mp4, webm
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** gtk3, cairo, ffmpeg, boost
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later
**Executable (manifest canonical path).** `packages/2d-animation/synfig/active/bin/synfigstudio`
**Launch.** `studioctl launch synfig` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id synfig`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
