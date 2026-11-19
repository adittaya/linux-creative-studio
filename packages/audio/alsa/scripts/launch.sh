#!/usr/bin/env bash
# Preferred entry point: studioctl launch alsa
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch alsa "$@"
