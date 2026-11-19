#!/usr/bin/env bash
# Preferred entry point: studioctl launch scribus
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch scribus "$@"
