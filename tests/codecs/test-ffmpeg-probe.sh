#!/usr/bin/env bash
# Generate a 1-second test clip and inspect it with ffprobe.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
OUT="$ROOT/logs/test-codecs-ffmpeg.json"
FF=$(command -v ffmpeg || true); FP=$(command -v ffprobe || true)
if [[ -z "$FF" || -z "$FP" ]]; then
  printf '{"test":"ffmpeg-probe","status":"skipped","reason":"ffmpeg/ffprobe not installed"}\n' > "$OUT"
  echo "SKIPPED: ffmpeg/ffprobe not installed"; exit 0
fi
CLIP="$ROOT/workspaces/renders/test-clip.mp4"
mkdir -p "$(dirname "$CLIP")"
"$FF" -hide_banner -loglevel error -f lavfi -i testsrc=duration=1:size=320x180:rate=24 \
  -f lavfi -i sine=frequency=440:duration=1 -c:v libx264 -preset ultrafast -pix_fmt yuv420p \
  -c:a aac -shortest -y "$CLIP"
"$FP" -v error -show_entries stream=codec_name,codec_type,width,height,r_frame_rate -show_entries format=duration \
  -of json "$CLIP" > "$ROOT/logs/test-codecs-ffprobe.json"
python3 - "$OUT" "$ROOT/logs/test-codecs-ffprobe.json" "$CLIP" <<'PY'
import json, sys, os
d = json.load(open(sys.argv[2]))
video = [s for s in d.get("streams", []) if s.get("codec_type") == "video"]
ok = bool(video) and os.path.getsize(sys.argv[3]) > 0
result = {"test": "ffmpeg-probe", "status": "passed" if ok else "failed",
          "clip": sys.argv[3], "streams": d.get("streams", []), "duration": d.get("format", {}).get("duration")}
json.dump(result, open(sys.argv[1], "w"), indent=2)
print(result["status"].upper(), sys.argv[3])
PY
