#!/usr/bin/env bash
# Prepare verified offline artifacts. Downloads ONLY artifacts with a pinned SHA-256.
set -euo pipefail
STUDIO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$STUDIO_ROOT/scripts/common.sh"

PACKAGES=(); SUITE=""; CATEGORY=""; ALL=0; MANIFEST=""; DRY=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    --package) PACKAGES+=("$2"); shift 2 ;;
    --suite) SUITE="$2"; shift 2 ;;
    --category) CATEGORY="$2"; shift 2 ;;
    --all) ALL=1; shift ;;
    --artifacts-manifest) MANIFEST="$2"; shift 2 ;;
    --dry-run) DRY=1; DRY_RUN=1; shift ;;
    *) usage_or_die "unknown option: $1" ;;
  esac
done
DRY_RUN="$DRY"

mapfile -t IDS < <(python3 - "$STUDIO_ROOT" "$SUITE" "$CATEGORY" "$ALL" "${PACKAGES[@]}" <<'PY'
import json, sys
root, suite, category, all_ = sys.argv[1:5]
selected = sys.argv[5:]
apps = json.load(open(root + "/registry/applications.json"))["applications"]
if all_ == "1":
    ids = [a["id"] for a in apps]
elif selected:
    ids = selected
else:
    ids = [a["id"] for a in apps if (not suite or a["category"] == suite) and (not category or a["category"] == category)]
for i in ids:
    print(i)
PY
)
[[ ${#IDS[@]} -gt 0 ]] || die "no packages selected"

log "download plan: ${#IDS[@]} package(s); dry-run=$DRY"
if [[ -z "$MANIFEST" ]]; then
  for id in "${IDS[@]}"; do
    log "  $id — no pinned artifact manifest supplied; nothing downloaded"
  done
  log "To fetch artifacts, pass --artifacts-manifest FILE (JSON list of {id,url,sha256,kind,filename})."
  exit 0
fi
[[ -f "$MANIFEST" ]] || die "artifacts manifest not found: $MANIFEST"
need_cmd curl

python3 - "$MANIFEST" "${IDS[@]}" <<'PY'
import json, sys, pathlib
items = json.load(open(sys.argv[1]))
selected = set(sys.argv[2:])
allowed_kinds = {"appimages", "deb-packages", "portable-archives", "python-wheels",
                 "npm-cache", "source-archives", "flatpak", "apt/debian", "apt/ubuntu"}
for it in items:
    assert isinstance(it, dict), "manifest entries must be objects"
    assert it.get("id") in selected, f"id {it.get('id')} not selected"
    assert str(it.get("url", "")).startswith("https://"), f"only https URLs allowed: {it.get('url')}"
    assert len(str(it.get("sha256", ""))) == 64, f"sha256 required for {it.get('id')}"
    assert it.get("kind") in allowed_kinds, f"bad kind: {it.get('kind')}"
    name = pathlib.Path(it.get("filename", "")).name
    assert name and name == it.get("filename"), f"filename must be a basename: {it.get('filename')}"
print(f"validated {len(items)} artifact record(s)")
PY

count=0
while IFS=$'\t' read -r id kind filename url sha; do
  [[ -n "$id" ]] || continue
  dest="$STUDIO_ROOT/offline-repo/$kind/$filename"
  tmp="$STUDIO_ROOT/cache/downloads/$filename.part"
  if [[ "$DRY" == "1" ]]; then
    log "dry-run: curl -fL --retry 3 '$url' -o '$tmp' && verify SHA-256 && move to '$dest'"
    count=$((count+1)); continue
  fi
  mkdir -p "$(dirname "$tmp")" "$(dirname "$dest")"
  log "downloading $id -> $filename"
  curl -fL --retry 3 --connect-timeout 20 "$url" -o "$tmp"
  actual=$(sha256sum "$tmp" | awk '{print $1}')
  if [[ "$actual" != "$sha" ]]; then
    rm -f -- "$tmp"
    die "checksum mismatch for $id: expected $sha got $actual"
  fi
  mv -f -- "$tmp" "$dest"
  printf '%s  %s\n' "$sha" "${dest#$STUDIO_ROOT/}" >> "$STUDIO_ROOT/offline-repo/checksums/SHA256SUMS"
  printf '{"id":"%s","url":"%s","sha256":"%s","kind":"%s","filename":"%s","downloaded_at":"%s"}\n' \
    "$id" "$url" "$sha" "$kind" "$filename" "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
    >> "$STUDIO_ROOT/offline-repo/checksums/provenance.jsonl"
  log "verified and cached: ${dest#$STUDIO_ROOT/}"
  count=$((count+1))
done < <(python3 - "$MANIFEST" <<'PY'
import json, sys
for it in json.load(open(sys.argv[1])):
    print("\t".join([it["id"], it["kind"], it["filename"], it["url"], it["sha256"]]))
PY
)
if [[ "$DRY" != "1" ]]; then
  python3 - "$STUDIO_ROOT" "$count" <<'PY'
import json, sys
p = sys.argv[1] + "/registry/package-index.json"
d = json.load(open(p))
d["artifact_count"] = d.get("artifact_count", 0) + int(sys.argv[2])
json.dump(d, open(p, "w"), indent=2)
PY
  log "downloaded and verified $count artifact(s)"
else
  log "dry-run: $count artifact(s) would be downloaded and verified"
fi
