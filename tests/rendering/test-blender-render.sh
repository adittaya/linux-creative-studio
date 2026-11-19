#!/usr/bin/env bash
# Render a simple Blender scene headlessly and validate the output image.
# Prefers the bundle's pinned portable Blender build.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUT="$ROOT/logs/test-rendering-blender.json"
LOCAL="$ROOT/packages/3d/blender/active/bin/blender"
# Extract the pinned archive on demand (offline, no system changes) when needed.
if [[ ! -x "$LOCAL" ]]; then
  bash "$ROOT/scripts/install.sh" --package blender --confirm >/dev/null 2>&1 || true
fi
BLENDER="$LOCAL"
if [[ ! -x "$BLENDER" ]]; then
  BLENDER=$(command -v blender || true)
fi
if [[ -z "$BLENDER" || ! -x "$BLENDER" ]]; then
  printf '{"test":"blender-render","status":"skipped","reason":"blender not installed"}\n' > "$OUT"
  echo "SKIPPED: blender not installed"; exit 0
fi
IMG="$ROOT/workspaces/renders/blender-test.png"
mkdir -p "$(dirname "$IMG")" "$ROOT/logs"
"$BLENDER" -b --python "$ROOT/templates/blender/scene_template.py" -- --output "$IMG" > "$ROOT/logs/blender-render.log" 2>&1
python3 - "$OUT" "$IMG" "$BLENDER" <<'PY'
import json, os, sys
ok = os.path.isfile(sys.argv[2]) and os.path.getsize(sys.argv[2]) > 1000
json.dump({"test":"blender-render","status":"passed" if ok else "failed",
           "executable":sys.argv[3],"output":sys.argv[2],
           "bytes":os.path.getsize(sys.argv[2]) if os.path.exists(sys.argv[2]) else 0},
          open(sys.argv[1],"w"), indent=2)
print("PASSED" if ok else "FAILED", sys.argv[2])
PY
