#!/usr/bin/env bash
# Preferred entry point: studioctl launch krita
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch krita "$@"
