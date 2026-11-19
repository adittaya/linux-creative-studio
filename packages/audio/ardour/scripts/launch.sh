#!/usr/bin/env bash
# Preferred entry point: studioctl launch ardour
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch ardour "$@"
