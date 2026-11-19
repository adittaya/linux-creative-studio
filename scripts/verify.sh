#!/usr/bin/env bash
# Structural + optional smoke verification. Writes JSON to logs/verification-latest.json.
set -euo pipefail
STUDIO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$STUDIO_ROOT/scripts/common.sh"

SMOKE=0; ID=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --smoke) SMOKE=1; shift ;;
    --id) ID="$2"; shift 2 ;;
    *) usage_or_die "unknown option: $1" ;;
  esac
done
ARGS=(verify --json)
[[ "$SMOKE" == "1" ]] && ARGS+=(--smoke)
[[ -n "$ID" ]] && ARGS+=(--id "$ID")
"$STUDIO_ROOT/studioctl" "${ARGS[@]}" > "$STUDIO_ROOT/logs/verification-latest.json"
python3 - "$STUDIO_ROOT" <<'PY'
import json, sys
d = json.load(open(sys.argv[1] + "/logs/verification-latest.json"))
print(f"checked={d['checked']} passed={d['passed']} smoke={d['smoke']}")
for r in d["results"]:
    print(f"  {r['id']:<26} {r['verdict']}")
if d["checked"] and d["passed"] == d["checked"]:
    print("NOTE: structural verification only; functional tests require tests/ on target hardware.")
PY
