#!/usr/bin/env bash
# Preferred entry point: studioctl launch natron
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch natron "$@"
