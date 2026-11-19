#!/usr/bin/env bash
# Adapter for lottie. Does not fetch or execute unverified binaries.
set -euo pipefail
STUDIO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
# shellcheck source=../../../../scripts/common.sh
source "$STUDIO_ROOT/scripts/common.sh"
PKG="$STUDIO_ROOT/packages/motion/lottie"
log "install lottie: manifest $PKG/metadata/application.json"
if [[ "${DRY_RUN:-0}" == "1" ]]; then log "dry run: no changes"; exit 0; fi
die "No verified artifact is cached for lottie. Run studioctl doctor and scripts/download-packages.sh on a preparation machine first."
