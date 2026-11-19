#!/usr/bin/env bash
# Preferred entry point: studioctl launch material-maker
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch material-maker "$@"
