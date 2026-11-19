#!/usr/bin/env bash
# Preferred entry point: studioctl launch luxcorerender
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch luxcorerender "$@"
