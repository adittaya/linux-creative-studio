#!/usr/bin/env bash
# Preferred entry point: studioctl launch mlt
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch mlt "$@"
