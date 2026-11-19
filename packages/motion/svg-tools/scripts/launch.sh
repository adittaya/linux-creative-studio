#!/usr/bin/env bash
# Preferred entry point: studioctl launch svg-tools
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch svg-tools "$@"
