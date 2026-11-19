#!/usr/bin/env bash
# Offline-state report. Never opens a network connection.
set -euo pipefail
STUDIO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$STUDIO_ROOT/scripts/common.sh"
"$STUDIO_ROOT/studioctl" offline-check --json > "$STUDIO_ROOT/logs/offline-check-latest.json"
python3 - "$STUDIO_ROOT" <<'PY'
import json, sys
d = json.load(open(sys.argv[1] + "/logs/offline-check-latest.json"))
print("Offline readiness summary (no network used):")
for k, v in sorted(d["summary"].items()):
    print(f"  {k:<24} {v}")
restricted = [a["id"] for a in d["applications"] if not a["offline_capable"]]
print("Restricted/license-gated:", ", ".join(restricted) or "none")
PY
