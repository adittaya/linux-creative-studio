# Linux Reverse Engineering Offline Packages

Simple documentation + release manifests for offline/remedy package bundles.

- Release assets: https://github.com/adittaya/linux-creative-studio/releases/tag/reverse-engineering-offline-packages
- Package index: [docs/PACKAGE_RELEASE_INDEX.md](docs/PACKAGE_RELEASE_INDEX.md)
- Agent index: [release/RELEASE_MANIFEST.json](release/RELEASE_MANIFEST.json)

## Use

1. Find package in `docs/PACKAGE_RELEASE_INDEX.md` or `release/packages.json`.
2. Download the asset from the release.
3. Verify with `release/SHA256SUMS.txt`.
4. Unzip and read `metadata.json`, `README.md`, `VERIFY.md`, `install.sh` inside the package.

## Repo contents

- `docs/` - source docs and package index
- `release/` - manifests and checksums
- `scripts/` - download/verify helpers
- `AGENT_GUIDE.md` - machine usage
- `SECURITY.md` - verify before install
