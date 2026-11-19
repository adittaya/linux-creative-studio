#!/usr/bin/env bash
set -euo pipefail
STUDIO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$STUDIO_ROOT/scripts/common.sh"
log "uninstall natron: remove only files under packages/2.5d-vfx/natron/active and recorded launcher entries"
if [[ "${DRY_RUN:-0}" == "1" ]]; then log "dry run: no changes"; exit 0; fi
warn "Automatic removal intentionally disabled; review package metadata and remove explicitly."
