#!/usr/bin/env bash
# Preferred entry point: studioctl launch pencil2d
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch pencil2d "$@"
