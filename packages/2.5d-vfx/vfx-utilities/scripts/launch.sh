#!/usr/bin/env bash
# Preferred entry point: studioctl launch vfx-utilities
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch vfx-utilities "$@"
