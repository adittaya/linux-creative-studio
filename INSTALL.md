# Installation

Nothing is installed on the target automatically. The **connected preparation step is already done**
for this bundle: 1,615 SHA-256-verified `.deb` packages, portable Blender 5.3.0, the Remotion npm
cache and Chrome Headless Shell are present. On the **target machine**, everything installs from
those local files — no egress is required.

## 0. Inspect the target first

```bash
./scripts/detect-system.sh
./scripts/detect-hardware.sh
./studioctl doctor --json
./scripts/offline-check.sh
```

Do not continue if `target_supported` is false. Debian stable and Ubuntu LTS on x86_64 are primary;
ARM64 is supported only where upstream binaries and dependencies exist (see `COMPATIBILITY.md`).

## 1. Installation profiles (planning estimates)

| Profile | Packages | Estimated space |
|---|---|---|
| `minimal` | FFmpeg, ImageMagick, GIMP, Audacity, Python 3, Git | ~4–8 GB |
| `standard` | core 2D, video, audio, 3D and media infrastructure | ~25 GB |
| `full-studio` | all open-source packages with available artifacts | ~90 GB |
| `rendering-workstation` | Blender, OIDN, Natron, color tools, high-volume caches | ~120 GB |
| `video-production` | Kdenlive, Shotcut, FFmpeg, color, audio | ~35 GB |
| `ai-automation-workstation` | Remotion/Node/npm cache/Chromium/FFmpeg/Blender | ~40 GB |

Estimates are planning values, not measured artifact totals. Run `scripts/download-packages.sh`
with a pinned manifest first; the actual resolved artifact list is recorded in `OFFLINE_BUNDLE_MANIFEST.json`.

## 2. Acquire additional artifacts (only if you need apps not already cached)

The bundle already contains the artifacts listed in `OFFLINE_BUNDLE_MANIFEST.json`.
To extend it on a connected machine:

```bash
# See the plan (no download)
./scripts/download-packages.sh --suite 3d --dry-run

# Download only HTTPS artifacts with a pinned SHA-256
./scripts/download-packages.sh --artifacts-manifest /path/to/artifacts.json --dry-run
./scripts/download-packages.sh --artifacts-manifest /path/to/artifacts.json
```

Manifest format:

```json
[
  {"id":"blender","kind":"portable-archives","filename":"blender-5.3.0-linux-x64.tar.xz",
   "url":"https://download.blender.org/release/Blender5.3/blender-5.3.0-linux-x64.tar.xz",
   "sha256":"<64 hex characters from the upstream checksum file>"}
]
```

Allowed `kind` values: `appimages`, `deb-packages`, `portable-archives`, `python-wheels`,
`npm-cache`, `source-archives`, `flatpak`, `apt/debian`, `apt/ubuntu`.
The script refuses non-HTTPS URLs, non-basename filenames and missing checksums.

## 3. Build repository indexes

```bash
./scripts/create-repository.sh apt
./scripts/create-repository.sh flatpak
./scripts/create-repository.sh npm
```

## 4. Install on the target

```bash
# Preview only
./scripts/install.sh --suite 2d-image --dry-run
./scripts/install.sh --package gimp --dry-run
./scripts/install.sh --profile programmatic-video --dry-run

# Actual installation (with explicit confirmation)
./scripts/install.sh --package gimp --confirm --confirm-system-change
./scripts/install.sh --suite video --confirm --confirm-system-change
# Blender portable build is extracted without touching the system:
./scripts/install.sh --package blender --confirm
# Remotion dependencies reinstall from the local npm cache:
./scripts/install.sh --package remotion --confirm
```

APT packages are resolved through `offline-repo/apt/local-sources.list` (a `file:` repository built
by `create-repository.sh apt`), so dependency resolution and installation never contact a mirror.
Per-application adapters live at `packages/<category>/<id>/scripts/install.sh`.
They only install from files already inside `offline-repo/` and log every action to `logs/`.

## 5. Verify (never trust exit codes alone)

```bash
./scripts/verify.sh --smoke
./studioctl doctor --json
# Functional tests on a real host:
bash tests/rendering/test-blender-render.sh
bash tests/codecs/test-ffmpeg-probe.sh
```

Status vocabulary: `installed`, `verified`, `offline-verified`, `partially verified`,
`incompatible`, `not tested`. Only the matching test logs may raise an application's status.

## 6. Removal, repair and updates

```bash
./scripts/uninstall.sh --package gimp --dry-run
./scripts/uninstall.sh --package gimp --confirm
./scripts/repair.sh --dry-run
./scripts/update.sh blender --dry-run
```

Updates require a reviewed replacement artifact and a rollback plan; automatic updates are refused.

## Method support

| Method | Notes |
|---|---|
| APT snapshot | 1,615 packages from **Ubuntu 24.04 noble base** (amd64) in `offline-repo/deb-packages/`; indexes copied to `offline-repo/apt/{ubuntu,debian}/`. Do not mix with Debian codenames. |
| Flatpak | Local repository plus runtimes; verify redistribution rights before populating. |
| AppImage | Stored with source/version/SHA-256; host FUSE, fonts and GPU libraries are still required. |
| Portable archive | Extracted under `<package>/active/`; no relocation of system libraries. |
| Python wheels | Wheelhouse under `offline-repo/python-wheels`; install into a venv in `runtimes/python/`. |
| npm | Lockfile + cache; see `offline-repo/npm-cache/README.md`. |
| Optional commercial | See `installers/optional-commercial/`, `LICENSES.md`; never redistributed here. |
