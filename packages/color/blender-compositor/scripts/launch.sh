#!/usr/bin/env bash
# Preferred entry point: studioctl launch blender-color-management
set -euo pipefail
exec "$(dirname "${BASH_SOURCE[0]}")/../../../../studioctl" launch blender-color-management "$@"
