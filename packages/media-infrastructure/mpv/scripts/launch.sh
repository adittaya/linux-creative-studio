#!/usr/bin/env bash
# Preferred entry point: studioctl launch mpv
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch mpv "$@"
