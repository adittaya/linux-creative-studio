# Agent Guide

## Files
- `release/RELEASE_MANIFEST.json` - all assets with direct `download_url`, `asset_sha256`, `kind`.
- `release/packages.json` - package entries.
- `release/bundles.json` - bundle entries.

## Workflow
1. Resolve package by `id`/`name`/`capabilities` in `release/packages.json`.
2. Download `download_url`.
3. Verify SHA256 against `release/SHA256SUMS.txt`.
4. Unzip; read `metadata.json`, `install.sh`, `VERIFY.md`, `acquire.log`.
5. Use `artifacts/` if present; otherwise follow upstream `url` and `install` method.

## Notes
- Install scripts are guarded helpers; review before execution.
- Check `license_warning`/`caveat` fields.
