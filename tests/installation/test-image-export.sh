#!/usr/bin/env bash
# Deterministic image edit + export test. Uses ImageMagick when available;
# explicitly labelled as a substitute test, not a GIMP/Krita UI test.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUT="$ROOT/logs/test-installation-image-export.json"
MAGICK=$(command -v magick || command -v convert || true)
if [[ -z "$MAGICK" ]]; then
  printf '{"test":"image-export","status":"skipped","reason":"ImageMagick not installed"}\n' > "$OUT"
  echo "SKIPPED: ImageMagick not installed"; exit 0
fi
TMP="$ROOT/workspaces/temporary/test-input.png"
RESULT="$ROOT/workspaces/exports/test-output.png"
mkdir -p "$(dirname "$TMP")" "$(dirname "$RESULT")"
"$MAGICK" -size 320x180 gradient:'#0b1220-#5eead4' "$TMP"
"$MAGICK" "$TMP" -resize 160x90 -colorspace sRGB "$RESULT"
python3 - "$OUT" "$TMP" "$RESULT" <<'PY'
import json, os, sys
ok = all(os.path.getsize(p) > 100 for p in sys.argv[2:])
json.dump({"test":"image-export","tool":"ImageMagick (GIMP/Krita substitute)","status":"passed" if ok else "failed",
           "input":sys.argv[2],"output":sys.argv[3]}, open(sys.argv[1],"w"), indent=2)
print("PASSED" if ok else "FAILED")
PY
