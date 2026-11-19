#!/usr/bin/env bash
# Preferred entry point: studioctl launch shutter-encoder
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch shutter-encoder "$@"
