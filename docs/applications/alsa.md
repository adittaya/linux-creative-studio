# ALSA — application notes

**Purpose.** Linux kernel audio interface and userspace utilities
**Suitable tasks.** Linux kernel audio interface and userspace utilities
**Capabilities.** audio-server, audio-device-management, audio-routing
**Formats.** conf, wav
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** kernel-sound-stack
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later and LGPL-2.1-or-later
**Executable (manifest canonical path).** `packages/audio/alsa/active/bin/alsamixer`
**Launch.** `studioctl launch alsa` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id alsa`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
