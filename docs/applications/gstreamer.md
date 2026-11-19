# GStreamer — application notes

**Purpose.** Modular multimedia pipeline framework and plugins
**Suitable tasks.** Modular multimedia pipeline framework and plugins
**Capabilities.** media-pipeline, media-conversion, streaming, capture, scripting
**Formats.** mp4, mkv, webm, wav, png, rtsp
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** glib2, plugin-base, plugin-good, plugin-bad, plugin-ugly, libav
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** LGPL-2.1-or-later
**Executable (manifest canonical path).** `packages/media-infrastructure/gstreamer/active/bin/gst-launch-1.0`
**Launch.** `studioctl launch gstreamer` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id gstreamer`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
