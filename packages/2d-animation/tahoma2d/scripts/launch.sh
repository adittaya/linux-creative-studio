#!/usr/bin/env bash
# Preferred entry point: studioctl launch tahoma2d
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch tahoma2d "$@"
