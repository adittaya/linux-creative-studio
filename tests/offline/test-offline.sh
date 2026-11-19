#!/usr/bin/env bash
# Offline smoke suite. Run on an isolated target host with egress blocked.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUT="$ROOT/logs/test-offline.json"
cd "$ROOT"
"$ROOT/studioctl" doctor --json > logs/offline-doctor.json
"$ROOT/studioctl" offline-check --json > logs/offline-check-test.json
"$ROOT/scripts/verify.sh" --smoke > logs/offline-verify.txt
bash tests/codecs/test-ffmpeg-probe.sh || true
bash tests/installation/test-image-export.sh || true
bash tests/rendering/test-blender-render.sh || true
bash tests/rendering/test-remotion-render.sh || true
python3 - "$OUT" "$ROOT" <<'PY'
import json, os, sys
root = sys.argv[2]
logs = ["test-codecs-ffmpeg.json","test-installation-image-export.json",
        "test-rendering-blender.json","test-rendering-remotion.json"]
results = {}
for name in logs:
    p = os.path.join(root, "logs", name)
    if os.path.isfile(p):
        try:
            d = json.load(open(p))
            results[name] = d.get("status", "unknown")
        except Exception:
            results[name] = "invalid-log"
    else:
        results[name] = "missing-log"
offline = json.load(open(os.path.join(root, "logs", "offline-check-test.json")))
verdict = "partially-verified" if any(v == "passed" for v in results.values()) else "not-verified"
json.dump({"test":"offline-suite","status":verdict,"functional_results":results,
           "offline_summary":offline.get("summary",{}),
           "claim":"No offline guarantee until every required test passes on an isolated host."},
          open(sys.argv[1], "w"), indent=2)
print(verdict, results)
PY
