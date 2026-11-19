# PipeWire — application notes

**Purpose.** Modern low-latency audio/video server with JACK and ALSA compatibility
**Suitable tasks.** Modern low-latency audio/video server with JACK and ALSA compatibility
**Capabilities.** audio-server, audio-routing, audio-recording, low-latency-audio
**Formats.** conf, wav
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** dbus, alsa-lib, wireplumber
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** MIT and LGPL-2.1-or-later
**Executable (manifest canonical path).** `packages/audio/pipewire/active/bin/pipewire`
**Launch.** `studioctl launch pipewire` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id pipewire`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
