#!/usr/bin/env bash
# Preferred entry point: studioctl launch argyllcms
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch argyllcms "$@"
