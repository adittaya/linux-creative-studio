#!/usr/bin/env bash
set -euo pipefail
STUDIO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
source "$STUDIO_ROOT/scripts/common.sh"
log "uninstall libvips: remove only files under packages/2d-image/libvips/active and recorded launcher entries"
if [[ "${DRY_RUN:-0}" == "1" ]]; then log "dry run: no changes"; exit 0; fi
warn "Automatic removal intentionally disabled; review package metadata and remove explicitly."
