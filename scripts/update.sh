#!/usr/bin/env bash
# Update procedure: resolve new versions on a connected preparation machine.
set -euo pipefail
STUDIO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$STUDIO_ROOT/scripts/common.sh"
ID="${1:-}"
DRY="${DRY_RUN:-0}"
shift || true
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY=1; DRY_RUN=1; shift ;;
    *) usage_or_die "unknown option: $1" ;;
  esac
done
if [[ -z "$ID" ]]; then usage_or_die "usage: update.sh <package-id> [--dry-run]"; fi

"$STUDIO_ROOT/studioctl" info "$ID" --json >/dev/null || die "unknown package: $ID"
log "update $ID"
log "1. Research upstream release notes and license changes (metadata/sources.json)."
log "2. Download ONLY from official HTTPS source with pinned SHA-256: scripts/download-packages.sh --artifacts-manifest ..."
log "3. Verify checksum + signature where available; record provenance."
log "4. Install into a new active/ directory, keep the previous one for rollback."
log "5. Run: studioctl verify --id $ID --smoke && tests/..."
log "6. Update metadata, CHANGELOG.md and offline-repo/checksums/SHA256SUMS."
[[ "$DRY" == "1" ]] && { log "dry-run: no changes"; exit 0; }
die "Automatic update refused: requires reviewed artifacts and a rollback plan."
