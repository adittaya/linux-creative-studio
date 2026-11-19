# Linux Creative Studio — v1.0.0

A populated, offline-first creative production bundle for Ubuntu 24.04 LTS (noble), amd64.

## Release asset

Download **`Linux-Creative-Studio.zip`** from this release. It contains the complete
`Linux-Creative-Studio/` tree with all binaries pre-downloaded — no installation-time network access.

## Contents

- **1,615 SHA-256-verified `.deb` packages** — internally consistent Ubuntu 24.04 noble base closure
  covering 50+ open-source apps (Blender, GIMP, Krita, Inkscape, darktable, RawTherapee, digiKam,
  Kdenlive, Shotcut, OpenShot, Audacity, Ardour, FFmpeg, VLC, MPV, PipeWire, JACK, ALSA, fonts, …).
- **Local apt repository indexes** (`offline-repo/apt/`) so `scripts/install.sh` resolves dependencies
  through a local `file:` source.
- **Portable Blender 5.3.0** (upstream SHA-256 verified), extracted on demand by the installer.
- **Remotion 4.0.538** npm cache + pinned Chrome Headless Shell for offline `npm ci --offline` renders.
- **75 application manifests**, **168 capabilities**, **20 task profiles**, `studioctl` CLI, guarded
  installers, templates, presets, docs and tests.
- **1,622 checksummed artifacts** in `offline-repo/checksums/SHA256SUMS` and a full
  `OFFLINE_BUNDLE_MANIFEST.json`.

## Verified in the preparation environment

- `sha256sum -c offline-repo/checksums/SHA256SUMS` — all OK
- `studioctl doctor` — 0 problems
- Blender headless render — PASSED
- Remotion offline render (from npm cache + pinned browser) — PASSED
- FFmpeg/FFprobe codec probe — PASSED

## Honest limitations

- Not validated on a clean, isolated target host; `offline-verified` remains false.
- Pinned for Ubuntu 24.04 noble/amd64. Debian and ARM64 need separate closures.
- DaVinci Resolve and REAPER are documented but not redistributed.

See `FINAL_REPORT.md`, `OFFLINE_GUIDE.md` and `INSTALL.md` in the archive for full detail.
