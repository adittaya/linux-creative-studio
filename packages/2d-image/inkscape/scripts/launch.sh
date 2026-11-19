#!/usr/bin/env bash
# Preferred entry point: studioctl launch inkscape
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch inkscape "$@"
