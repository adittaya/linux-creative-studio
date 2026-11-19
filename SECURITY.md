# Security and integrity policy

## Enforced controls

- **HTTPS-only downloads** in `scripts/download-packages.sh`.
- **Mandatory SHA-256** for every cached artifact; mismatch aborts and deletes the partial file.
- **Pinned filenames** (basename only) prevent path traversal in the downloader.
- **Archive traversal check** before extraction in `install.sh`.
- **Allowlisted launches:** `studioctl launch` uses IDs from the registry, resolved absolute
  executable paths, argv arrays and `shell=False`. `--input` must exist and have an allowed extension.
- **No arbitrary installer execution:** every package adapter is reviewed shell code with `set -euo pipefail`;
  no `curl | sh`, no obfuscation, no `sudo` embedded.
- **Explicit confirmation** required for `.deb` system changes (`--confirm-system-change`).
- **Audit log:** all management scripts log to `logs/studio.log` with UTC timestamps.

## Prohibited

Cracked/modified binaries, licence bypasses, malware, unverified silent installs, disabling security
mechanisms, destructive commands without explicit authorisation, replacing system glibc/Python/kernel
or graphics drivers, mixing Debian and Ubuntu repositories.

## Verification chain

1. Upstream official source URL recorded in `metadata/sources.json` with research date.
2. SHA-256 from upstream checksum file pinned in the artifacts manifest.
3. SHA-256 re-check on the preparation machine; `offline-repo/checksums/SHA256SUMS` and
   `provenance.jsonl` updated.
4. GPG/signature verification where the upstream provides it (record command + result in `logs/`).
5. Target machine re-verifies before install: `sha256sum -c offline-repo/checksums/SHA256SUMS`.
6. Functional tests (`tests/`) and offline test on isolated host.

## SBOM and vulnerability review

`registry/dependencies.json` plus `OFFLINE_BUNDLE_MANIFEST.json` form a minimal component inventory.
For a full SBOM, run a CycloneDX/SPDX tool on the *populated* bundle and store output under `docs/`.
Check upstream security advisories at each version bump; a version being current at research time is
not a guarantee at install time. Note that Glaxnimate and DisplayCAL are flagged as unmaintained —
treat them as higher risk and isolate if used.

## Reporting a problem

Store sanitised logs under `logs/`, never include credentials or licence keys. Record the exact
distribution, architecture, artifact SHA-256 and reproduction command.
