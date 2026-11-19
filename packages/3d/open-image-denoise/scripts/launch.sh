#!/usr/bin/env bash
# Preferred entry point: studioctl launch open-image-denoise
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch open-image-denoise "$@"
