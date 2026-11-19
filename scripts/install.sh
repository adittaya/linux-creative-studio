#!/usr/bin/env bash
# Modular offline installer. Installs one package, a suite, or a profile.
# Guards: local checksummed artifacts only; explicit confirmation for system changes.
set -euo pipefail
STUDIO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$STUDIO_ROOT/scripts/common.sh"

PACKAGES=(); SUITE=""; PROFILE=""; ALL=0; DRY=0; CONFIRM=0; SYSTEM=0
while [[ $# -gt 0 ]]; do
  case "$1" in
    --package) PACKAGES+=("$2"); shift 2 ;;
    --suite) SUITE="$2"; shift 2 ;;
    --profile) PROFILE="$2"; shift 2 ;;
    --all) ALL=1; shift ;;
    --dry-run) DRY=1; DRY_RUN=1; shift ;;
    --confirm) CONFIRM=1; shift ;;
    --confirm-system-change) SYSTEM=1; shift ;;
    *) usage_or_die "unknown option: $1" ;;
  esac
done
DRY_RUN="$DRY"

mapfile -t IDS < <(python3 - "$STUDIO_ROOT" "$SUITE" "$PROFILE" "$ALL" "${PACKAGES[@]}" <<'PY'
import json, sys
root, suite, profile, all_ = sys.argv[1:5]
selected = list(sys.argv[5:])
apps = json.load(open(root + "/registry/applications.json"))["applications"]
if profile:
    profiles = json.load(open(root + "/registry/task-profiles.json"))["profiles"]
    found = next((x for x in profiles if x["id"] == profile), None)
    if not found:
        sys.exit(f"unknown profile: {profile}")
    selected = found["required"] + found["optional"]
if all_ == "1":
    selected = [a["id"] for a in apps]
if not selected and suite:
    selected = [a["id"] for a in apps if a["category"] == suite]
seen = set()
for i in selected:
    if i not in seen:
        seen.add(i)
        print(i)
PY
)
[[ ${#IDS[@]} -gt 0 ]] || die "no packages selected"

check_root_fs
SOURCES="$STUDIO_ROOT/offline-repo/apt/local-sources.list"
[[ -f "$SOURCES" ]] || die "local apt index missing; run scripts/create-repository.sh apt first"
MAP="$STUDIO_ROOT/registry/apt-package-map.json"
DEB_DIR="$STUDIO_ROOT/offline-repo/deb-packages"

APT_OPTS=(
  -o "Dir::Etc::sourcelist=$SOURCES"
  -o Dir::Etc::sourceparts=-
  -o APT::Get::List-Cleanup=0
  -o Acquire::AllowInsecureRepositories=true
  -o APT::Get::AllowUnauthenticated=true
)

log "offline install plan: ${#IDS[@]} package(s); dry-run=$DRY confirm-system=$SYSTEM"
installed=0; skipped=0; apt_names=(); portable_ids=(); npm_ids=()

for id in "${IDS[@]}"; do
  info=$(python3 - "$STUDIO_ROOT" "$id" <<'PY'
import json, sys
root, i = sys.argv[1:3]
a = next(x for x in json.load(open(root+"/registry/applications.json"))["applications"] if x["id"] == i)
print(a["package_path"])
PY
)
  apt_name=$(python3 - "$MAP" "$id" <<'PY'
import json, sys
print(json.load(open(sys.argv[1]))["mapping"].get(sys.argv[2], ""))
PY
)
  # A pinned portable build is version-exact and never touches the system; prefer it.
  if compgen -G "$STUDIO_ROOT/offline-repo/portable-archives/*${id}*" > /dev/null; then
    portable_ids+=("$id"); continue
  fi
  if [[ -n "$apt_name" ]] && compgen -G "$DEB_DIR/${apt_name}_*.deb" > /dev/null; then
    apt_names+=("$apt_name"); continue
  fi
  artifact=$(find "$STUDIO_ROOT/offline-repo" -type f \( -iname "*${id}*" -o -iname "*${apt_name}*" \) 2>/dev/null | head -1 || true)
  case "$artifact" in
    *.tar.xz|*.tar.gz|*.tgz)
      portable_ids+=("$id") ;;
    *)
      if [[ "$id" == "remotion" || "$id" == "nodejs" || "$id" == "react" || "$id" == "typescript" || "$id" == "lottie" ]] \
         && [[ -d "$STUDIO_ROOT/offline-repo/npm-cache/_cacache" ]]; then
        npm_ids+=("$id")
      else
        log "SKIP $id — no verified offline artifact. See docs/installation/"
        skipped=$((skipped+1))
      fi ;;
  esac
done

if [[ ${#apt_names[@]} -gt 0 ]]; then
  [[ "$SYSTEM" == "1" ]] || { log "SKIP apt packages (${apt_names[*]}) — pass --confirm-system-change"; skipped=$(( ${#apt_names[@]} + skipped )); apt_names=(); }
  if [[ ${#apt_names[@]} -gt 0 ]]; then
    if [[ "$DRY" == "1" ]]; then
      log "dry-run: apt-get ${APT_OPTS[*]} install -y --no-install-recommends ${apt_names[*]}"
    else
      need_cmd apt-get
      mkdir -p "$STUDIO_ROOT/cache/apt-lists/partial" "$STUDIO_ROOT/cache/apt-archives/partial"
      APT_OPTS+=(
        -o Dir::State::lists="$STUDIO_ROOT/cache/apt-lists"
        -o Dir::Cache::archives="$STUDIO_ROOT/cache/apt-archives"
      )
      apt-get "${APT_OPTS[@]}" update >/dev/null 2>&1 || warn "local apt index refresh failed; using cached index"
      apt-get "${APT_OPTS[@]}" install -y --no-install-recommends "${apt_names[@]}"
    fi
    installed=$((installed + ${#apt_names[@]}))
  fi
fi

for id in "${portable_ids[@]}"; do
  artifact=$(find "$STUDIO_ROOT/offline-repo/portable-archives" -type f -iname "*${id}*" | head -1)
  info=$(python3 - "$STUDIO_ROOT" "$id" <<'PY'
import json, sys
root, i = sys.argv[1:3]
a = next(x for x in json.load(open(root+"/registry/applications.json"))["applications"] if x["id"] == i)
print(a["package_path"])
PY
)
  target="$STUDIO_ROOT/$info/active"
  if [[ "$DRY" == "1" ]]; then
    log "dry-run: extract $artifact -> $target (after path traversal check)"
  else
    if tar -tf "$artifact" 2>/dev/null | grep -qE '(^|/)\.\.(/|$)'; then die "archive contains traversal path: $artifact"; fi
    mkdir -p "$target"
    tar --no-same-owner --no-same-permissions -xaf "$artifact" -C "$target"
    if [[ "$id" == "blender" ]]; then
      mkdir -p "$target/bin"
      cat > "$target/bin/blender" <<'WRAP'
#!/usr/bin/env bash
# Offline wrapper for the pinned portable Blender build.
set -euo pipefail
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$HERE/../../../../.." && pwd)"
LIB="$ROOT/runtimes/x86_64-linux/lib/usr/lib/x86_64-linux-gnu"
if [ -d "$LIB" ]; then
  export LD_LIBRARY_PATH="$LIB${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
fi
exec "$HERE/../blender-5.3.0-linux-x64/blender" "$@"
WRAP
      chmod 0755 "$target/bin/blender"
      local_lib="$STUDIO_ROOT/runtimes/x86_64-linux/lib"
      mkdir -p "$local_lib"
      for libdeb in "$DEB_DIR"/libsm6_*.deb "$DEB_DIR"/libice6_*.deb; do
        [[ -f "$libdeb" ]] && dpkg-deb -x "$libdeb" "$local_lib"
      done
      log "prepared portable Blender wrapper and local X11 libraries"
    fi
    chmod -R go-w "$target"
    log "extracted $id -> $target"
  fi
  installed=$((installed+1))
done

if [[ ${#npm_ids[@]} -gt 0 ]]; then
  STARTER="$STUDIO_ROOT/templates/remotion/starter"
  if [[ "$DRY" == "1" ]]; then
    log "dry-run: npm ci --offline --cache $STUDIO_ROOT/offline-repo/npm-cache (in $STARTER)"
  else
    need_cmd npm
    (cd "$STARTER" && npm ci --offline --no-audit --no-fund --cache "$STUDIO_ROOT/offline-repo/npm-cache")
  fi
  installed=$((installed + ${#npm_ids[@]}))
fi

log "summary: installed/planned=$installed skipped=$skipped"
[[ "$installed" -gt 0 || "$DRY" == "1" ]] || warn "nothing installed; artifacts and confirmation are required"
