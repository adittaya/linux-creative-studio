#!/usr/bin/env bash
# Preferred entry point: studioctl launch fontforge
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch fontforge "$@"
