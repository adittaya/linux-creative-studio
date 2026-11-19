# Offline packaging guide

## What "offline-first" means here

Every artifact must be present locally, checksummed, and described by source + licence before an
application is marked available. **This bundle is populated:** 1,615 `.deb` packages, portable Blender
5.3.0, the pinned Remotion npm cache and Chrome Headless Shell are on disk and listed in
`OFFLINE_BUNDLE_MANIFEST.json` / `offline-repo/checksums/SHA256SUMS`.

## Bundle contents (Ubuntu 24.04 noble, amd64)

| Component | Count / version | Location |
|---|---|---|
| Verified apt packages | 1,615 from noble base (`main`, `universe`, `restricted`, `multiverse`) | `offline-repo/deb-packages/` |
| Local apt indexes | `Packages`, `Packages.gz`, `Release`, `local-sources.list` | `offline-repo/apt/` |
| Portable Blender | 5.3.0 linux-x64, upstream SHA-256 verified | `offline-repo/portable-archives/`, `packages/3d/blender/active/` |
| Remotion npm cache | lockfile-derived, `npm ci --offline` verified | `offline-repo/npm-cache/` |
| Chrome Headless Shell | pinned build used by Remotion 4.0.538 | `runtimes/browsers/chrome-headless-shell/` |
| Total checksummed files | 1,622 | `offline-repo/checksums/SHA256SUMS` |

The apt closure was resolved with an **empty dpkg status** against the stable noble base release so it
is internally consistent; it is not a mixture of stale `-updates` snapshots. Debian targets need a
separate closure (see `COMPATIBILITY.md`).

## Preparation machine workflow

1. **Detect targets.** Run `scripts/detect-system.sh` and `scripts/detect-hardware.sh` for each
   target distribution, release and architecture. Record glibc version and available graphics stack.
2. **Resolve versions.** Use each package's `metadata/sources.json` and upstream checksum files.
   Pin exact versions; do not accept "latest" at install time.
3. **Download permitted artifacts.** `scripts/download-packages.sh --artifacts-manifest FILE`.
   HTTPS only, SHA-256 mandatory, provenance appended to
   `offline-repo/checksums/provenance.jsonl`.
4. **Transitive dependencies.** For APT use a clean container/VM of the exact release and
   `apt-get download` with `--print-uris` to enumerate dependencies; never mix Debian and Ubuntu.
   For npm use a lockfile and `npm ci` to populate the cache. For Python use `pip download`
   into `offline-repo/python-wheels`. For Flatpak use `flatpak install --user` then
   `flatpak create-usb` / local repository update where licensing allows.
5. **Verify.** Check SHA-256, GPG/signature where available, and archive path traversal.
6. **Generate checksums.** `offline-repo/checksums/SHA256SUMS`.
7. **Generate indexes.** `scripts/create-repository.sh all`.
8. **Generate manifest.** `python3 scripts/generate-manifest.py`.
9. **Test offline.** On an isolated host (network disabled or egress blocked):
   `scripts/offline-check.sh`, `studioctl doctor --json`, `scripts/verify.sh --smoke`,
   then the functional tests in `tests/`.
10. **Bundle.** Copy the whole `Linux-Creative-Studio/` directory to USB/external disk.
   It is self-describing; no absolute paths are required.

## Target machine workflow

```bash
./scripts/detect-system.sh            # confirm compatible release/architecture
./studioctl doctor --json
./scripts/offline-check.sh
./scripts/install.sh --package <id> --confirm --confirm-system-change   # apt packages
./scripts/install.sh --package blender --confirm                        # portable archive
./scripts/install.sh --package remotion --confirm                       # local npm cache
./studioctl verify --id <id> --smoke
bash tests/offline/test-offline.sh
```

Do not install the same application from multiple methods at once; prefer distribution packages for
system-integrated tools and portable/AppImage for version-pinned creative applications.

## Known unavoidable online dependencies

| Item | Reason | Handling |
|---|---|---|
| DaVinci Resolve | vendor installer, licence/account, redistribution prohibited | `installers/optional-commercial/`, not part of offline bundle |
| REAPER | evaluation/commercial licence | separate acquisition |
| Remotion | company-size-dependent licence terms; pinned Chromium download | read `https://remotion.dev/license`; cache browser explicitly |
| Some plug-ins/fonts/HDRIs | authored third-party assets | include only license-cleared files with attribution |
| GPU driver installers | vendor-specific, kernel-linked | never bundled/auto-installed; user-approved only |
| DisplayCAL | upstream dormant; no verified current Linux build | use Argyll CMS CLI path |

## Limitations to document per target

AppImages and Flatpaks do **not** include host GPU drivers, all fonts, or every host graphics library.
VA-API/NVENC/AMF encode support depends on the kernel driver and ffmpeg build. `scripts/detect-hardware.sh`
reports what is present; it does not enable it.

## Transfer checklist

- [ ] `registry/*.json` present and parseable
- [ ] `offline-repo/checksums/SHA256SUMS` matches all artifacts
- [ ] `OFFLINE_BUNDLE_MANIFEST.json` generated after final tests
- [ ] No proprietary binaries copied into the open-source bundle
- [ ] `logs/` contains detection, verification and functional test logs
- [ ] `PROGRESS.md` updated honestly
