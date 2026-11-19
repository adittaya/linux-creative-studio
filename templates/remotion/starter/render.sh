#!/usr/bin/env bash
# Offline Remotion render. Requires cached node_modules and browser runtime.
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STUDIO_ROOT="$(cd "$HERE/../../.." && pwd)"
export REMOTION_BROWSER_EXECUTABLE="${REMOTION_BROWSER_EXECUTABLE:-$STUDIO_ROOT/runtimes/browsers/chrome-headless-shell/chrome-headless-shell}"
export npm_config_cache="$STUDIO_ROOT/offline-repo/npm-cache"

[[ -x "$REMOTION_BROWSER_EXECUTABLE" ]] || { echo "cached browser missing: $REMOTION_BROWSER_EXECUTABLE" >&2; exit 1; }
[[ -d "$HERE/node_modules" ]] || { echo "node_modules missing; run npm ci --offline on the preparation machine" >&2; exit 1; }

mkdir -p "$STUDIO_ROOT/workspaces/renders/remotion"
cd "$HERE"
npm run render
"$HERE/../../../packages/media-infrastructure/ffmpeg/active/bin/ffmpeg" -hide_banner -i out/sample.mp4 -f null - 2>&1 | head -20 || true
