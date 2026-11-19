#!/usr/bin/env bash
# Remove studio-local installs. System packages are removed only with --confirm-system-change.
set -euo pipefail
STUDIO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$STUDIO_ROOT/scripts/common.sh"
ID=""; DRY=0; CONFIRM=0; SYSTEM=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    --package) ID="$2"; shift 2 ;;
    --dry-run) DRY=1; DRY_RUN=1; shift ;;
    --confirm) CONFIRM=1; shift ;;
    --confirm-system-change) SYSTEM=1; shift ;;
    *) usage_or_die "unknown option: $1" ;;
  esac
done
DRY_RUN="$DRY"
[[ -n "$ID" ]] || usage_or_die "usage: uninstall.sh --package <id> [--dry-run] [--confirm] [--confirm-system-change]"
PKG=$(python3 - "$STUDIO_ROOT" "$ID" <<'PY'
import json, sys
root, i = sys.argv[1:3]
a = next((x for x in json.load(open(root+"/registry/applications.json"))["applications"] if x["id"] == i), None)
if not a: sys.exit(f"unknown package: {i}")
print(a["package_path"])
PY
)
ACTIVE="$STUDIO_ROOT/$PKG/active"
if [[ -d "$ACTIVE" ]]; then
  if [[ "$DRY" == "1" ]]; then log "dry-run: rm -rf -- $ACTIVE"; else
    [[ "$CONFIRM" == "1" ]] || die "refusing to remove $ACTIVE without --confirm"
    in_studio "$ACTIVE" || die "refusing to remove path outside studio"
    rm -rf -- "$ACTIVE"; log "removed $ACTIVE"
  fi
else
  log "no studio-local active/ directory for $ID"
fi
if [[ "$SYSTEM" == "1" ]]; then
  [[ "$CONFIRM" == "1" ]] || die "--confirm-system-change also requires --confirm"
  log "system package removal must be reviewed manually (apt purge <exact-package-name>)"
fi
log "uninstall complete for $ID (registry metadata retained by design)"
