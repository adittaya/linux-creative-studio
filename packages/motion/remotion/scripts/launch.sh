#!/usr/bin/env bash
# Preferred entry point: studioctl launch react
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch react "$@"
