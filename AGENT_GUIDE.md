# Agent Guide

## Files
- `release/RELEASE_MANIFEST.json` - combined package and bundle entries for release assets.
- `release/packages.json` - package entries only.
- `release/bundles.json` - bundle entries only.
- `release/SHA256SUMS.txt` - checksums for files in the release asset directory.
- `docs/PACKAGE_RELEASE_INDEX.md` - human-readable package/bundle index.
- `docs/PACKAGE_RELEASE_INDEX.json` - machine-readable package/bundle index.

## Manifest fields
Common fields in package/bundle manifests:
- `kind` - `package` or `bundle`.
- `id`, `name` - stable identifier and display name.
- `asset`, `asset_sha256`, `asset_size`, `download_url` - release asset metadata.
- Package entries also include: `safe_id`, `capabilities`, `priority`, `install`, `role`, `url`, `license_warning`, `caveat`.
- Bundle entries also include: `type` (for example `apt-bundle`, `python-profile`, `docs`).

## Workflow
1. Resolve package by `id`/`name`/`capabilities` in `release/packages.json`.
2. Download `download_url`.
3. Verify SHA256 against `release/SHA256SUMS.txt`.
4. Unzip; read `metadata.json`, `install.sh`, `VERIFY.md`, `acquire.log`.
5. Use `artifacts/` if present; otherwise follow upstream `url` and `install` method.

## Rebuild
Regenerate release zips/manifests from a prepared work layout:

```bash
python3 scripts/rebuild_release.py \
  --work-dir work \
  --bundles-dir bundles \
  --docs-dir docs \
  --assets-dir release-assets \
  --repo-out . \
  --repo OWNER/REPO \
  --tag RELEASE_TAG
```

Inputs:
- `work/pkg/*` package directories (`metadata.json`, `artifact_hashes.json`, `artifacts/`, `acquire.log`, etc.).
- `bundles/*` bundle directories (optional `metadata.json`).

Outputs:
- `release-assets/pkg-<safe_id>.zip`, `release-assets/bundle-<name>.zip`
- `release/RELEASE_MANIFEST.json`, `release/packages.json`, `release/bundles.json`, `release/SHA256SUMS.txt`
- `docs/PACKAGE_RELEASE_INDEX.md`, `docs/PACKAGE_RELEASE_INDEX.json`

## Notes
- Install scripts are guarded helpers; review before execution.
- Check `license_warning`/`caveat` fields.
