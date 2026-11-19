#!/usr/bin/env bash
# Repair missing scaffold files and stale metadata without touching user data.
set -euo pipefail
STUDIO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$STUDIO_ROOT/scripts/common.sh"
DRY="${DRY_RUN:-0}"
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY=1; DRY_RUN=1; shift ;;
    *) usage_or_die "unknown option: $1" ;;
  esac
done

log "repair: regenerating scaffold/metadata (assets, projects and active/ are never modified)"
if [[ "$DRY" == "1" ]]; then log "dry-run: python3 scripts/_generate.py"; exit 0; fi
python3 "$STUDIO_ROOT/scripts/_generate.py"
chmod +x "$STUDIO_ROOT/studioctl" "$STUDIO_ROOT"/scripts/*.sh
chmod -R go-w "$STUDIO_ROOT"
# Restore offline-bundle state from the artifacts actually present on disk.
python3 "$STUDIO_ROOT/scripts/sync-artifact-status.py"
"$STUDIO_ROOT/scripts/create-repository.sh" apt >/dev/null
python3 "$STUDIO_ROOT/scripts/generate-manifest.py" >/dev/null
python3 "$STUDIO_ROOT/scripts/generate-final-report.py" >/dev/null
"$STUDIO_ROOT/studioctl" doctor --json > "$STUDIO_ROOT/logs/doctor-after-repair.json"
log "repair complete; doctor problems: $(python3 -c "import json;print(len(json.load(open('$STUDIO_ROOT/logs/doctor-after-repair.json'))['problems']))")"
