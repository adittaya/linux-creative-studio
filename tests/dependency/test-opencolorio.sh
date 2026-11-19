#!/usr/bin/env bash
# Validate an OpenColorIO config if present and ociocheck/ociobakelut is available.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUT="$ROOT/logs/test-dependency-ocio.json"
CFG=$(find "$ROOT/packages/color" "$ROOT/assets" -name 'config.ocio' -type f 2>/dev/null | head -1 || true)
CHECK=$(command -v ociocheck || true)
if [[ -z "$CHECK" || -z "$CFG" ]]; then
  printf '{"test":"opencolorio","status":"skipped","reason":"OCIO config or ociocheck not available","config":"%s"}\n' "$CFG" > "$OUT"
  echo "SKIPPED: OCIO config or ociocheck not available"; exit 0
fi
if "$CHECK" --input "$CFG" > "$ROOT/logs/ocio-check.log" 2>&1; then STATUS=passed; else STATUS=failed; fi
printf '{"test":"opencolorio","status":"%s","config":"%s"}\n' "$STATUS" "$CFG" > "$OUT"
echo "$STATUS: $CFG"
