#!/usr/bin/env bash
# Adapter for vfx-utilities. Does not fetch or execute unverified binaries.
set -euo pipefail
STUDIO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
# shellcheck source=../../../../scripts/common.sh
source "$STUDIO_ROOT/scripts/common.sh"
PKG="$STUDIO_ROOT/packages/2.5d-vfx/vfx-utilities"
log "install vfx-utilities: manifest $PKG/metadata/application.json"
if [[ "${DRY_RUN:-0}" == "1" ]]; then log "dry run: no changes"; exit 0; fi
die "No verified artifact is cached for vfx-utilities. Run studioctl doctor and scripts/download-packages.sh on a preparation machine first."
