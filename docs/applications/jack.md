# JACK Audio Connection Kit — application notes

**Purpose.** Low-latency audio routing for professional DAWs
**Suitable tasks.** Low-latency audio routing for professional DAWs
**Capabilities.** audio-server, audio-routing, low-latency-audio
**Formats.** conf, wav
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** alsa-lib, dbus
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later and LGPL-2.1-or-later
**Executable (manifest canonical path).** `packages/audio/jack/active/bin/jackd`
**Launch.** `studioctl launch jack` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id jack`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
