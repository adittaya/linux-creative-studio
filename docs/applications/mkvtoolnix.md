# MKVToolNix — application notes

**Purpose.** Matroska muxing, remuxing and subtitle tools
**Suitable tasks.** Matroska muxing, remuxing and subtitle tools
**Capabilities.** remuxing, subtitles, media-conversion, batch-processing
**Formats.** mkv, mp4, mov, srt, ass, ssa
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** boost, fmt, pugixml
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later
**Executable (manifest canonical path).** `packages/media-infrastructure/mkvtoolnix/active/bin/mkvmerge`
**Launch.** `studioctl launch mkvtoolnix` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id mkvtoolnix`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
