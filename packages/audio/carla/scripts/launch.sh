#!/usr/bin/env bash
# Preferred entry point: studioctl launch carla
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch carla "$@"
