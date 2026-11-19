#!/usr/bin/env bash
# Preferred entry point: studioctl launch davinci-resolve
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch davinci-resolve "$@"
