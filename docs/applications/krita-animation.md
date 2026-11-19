# Krita Animation — application notes

**Purpose.** Krita's timeline, onion-skin and video export workflow
**Suitable tasks.** Krita's timeline, onion-skin and video export workflow
**Capabilities.** 2d-animation, frame-by-frame, onion-skin, digital-painting, animation-export
**Formats.** kra, ora, png, mp4, gif
**Install methods.** capability facet only
**Runtime dependencies.** krita
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-3.0-or-later
**Executable (manifest canonical path).** `packages/2d-image/krita/active/bin/krita`
**Launch.** `studioctl launch krita-animation` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id krita-animation`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
Capability facet of Krita; not a separate binary. Launch with `studioctl launch krita`.
