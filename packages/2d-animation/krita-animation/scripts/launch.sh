#!/usr/bin/env bash
# Preferred entry point: studioctl launch krita-animation
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch krita-animation "$@"
