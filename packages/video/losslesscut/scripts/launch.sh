#!/usr/bin/env bash
# Preferred entry point: studioctl launch losslesscut
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch losslesscut "$@"
