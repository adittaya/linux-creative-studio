#!/usr/bin/env bash
# Offline Remotion render test. Skips unless cached deps + browser exist.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUT="$ROOT/logs/test-rendering-remotion.json"
STARTER="$ROOT/templates/remotion/starter"
BROWSER="${REMOTION_BROWSER_EXECUTABLE:-$ROOT/runtimes/browsers/chrome-headless-shell/chrome-headless-shell}"
skip() { printf '{"test":"remotion-render","status":"skipped","reason":"%s"}\n' "$1" > "$OUT"; echo "SKIPPED: $1"; exit 0; }
command -v npm >/dev/null || skip "npm not installed"
if [[ ! -x "$STARTER/node_modules/.bin/remotion" ]]; then
  (cd "$STARTER" && npm ci --offline --no-audit --no-fund --cache "$ROOT/offline-repo/npm-cache") \
    > "$ROOT/logs/remotion-offline-install.log" 2>&1 || skip "offline npm ci failed"
fi
[[ -x "$STARTER/node_modules/.bin/remotion" ]] || skip "node_modules not cached"
[[ -x "$BROWSER" ]] || skip "cached Remotion browser not present"
command -v ffmpeg >/dev/null || skip "ffmpeg not installed"
mkdir -p "$ROOT/logs"
(cd "$STARTER" && REMOTION_BROWSER_EXECUTABLE="$BROWSER" npm_config_cache="$ROOT/offline-repo/npm-cache" npm run render) \
  > "$ROOT/logs/remotion-render.log" 2>&1
python3 - "$OUT" "$STARTER/out/sample.mp4" <<'PY'
import json, os, sys, subprocess
p = sys.argv[2]
ok = os.path.isfile(p) and os.path.getsize(p) > 1000
probe = ""
if ok:
    r = subprocess.run(["ffprobe","-v","error","-show_entries","format=duration","-of","json",p],
                       capture_output=True, text=True)
    probe = r.stdout.strip()
json.dump({"test":"remotion-render","status":"passed" if ok else "failed","output":p,"ffprobe":probe},
          open(sys.argv[1],"w"), indent=2)
print("PASSED" if ok else "FAILED", p)
PY
