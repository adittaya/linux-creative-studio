#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/../../../../scripts/common.sh"
log "update openshot: resolve new version on a connected preparation machine, checksum, then replace cached artifact"
[[ "${DRY_RUN:-0}" == "1" ]] && exit 0
die "Not implemented without a verified replacement artifact."
