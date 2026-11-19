#!/usr/bin/env bash
# Preferred entry point: studioctl launch displaycal
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch displaycal "$@"
