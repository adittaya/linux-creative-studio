#!/usr/bin/env bash
# Build repository indexes from verified cached artifacts. No downloads.
set -euo pipefail
STUDIO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$STUDIO_ROOT/scripts/common.sh"

TARGET="${1:-all}"
case "$TARGET" in
  apt)
    need_cmd apt-ftparchive
    DEB="$STUDIO_ROOT/offline-repo/deb-packages"
    [[ -d "$DEB" && -n "$(ls -A "$DEB"/*.deb 2>/dev/null)" ]] || die "no cached .deb artifacts in $DEB"
    (
      cd "$DEB"
      apt-ftparchive packages . > Packages
      gzip -kf Packages
      apt-ftparchive release . > Release
    )
    mkdir -p "$STUDIO_ROOT/offline-repo/apt/ubuntu" "$STUDIO_ROOT/offline-repo/apt/debian"
    cp -f "$DEB"/Packages "$DEB"/Packages.gz "$DEB"/Release "$STUDIO_ROOT/offline-repo/apt/ubuntu/"
    cp -f "$DEB"/Packages "$DEB"/Packages.gz "$DEB"/Release "$STUDIO_ROOT/offline-repo/apt/debian/"
    # trusted=yes because this is a local, checksum-verified file repository with no signing key.
    printf 'deb [trusted=yes] file:%s ./\n' "$DEB" > "$STUDIO_ROOT/offline-repo/apt/local-sources.list"
    chmod 0644 "$STUDIO_ROOT/offline-repo/apt/local-sources.list"
    log "indexed $(find "$DEB" -maxdepth 1 -name '*.deb' | wc -l) .deb artifacts; wrote local-sources.list" ;;
  flatpak)
    need_cmd flatpak
    flatpak build-update-repo "$STUDIO_ROOT/offline-repo/flatpak/repository" || warn "empty flatpak repo; nothing to index"
    log "indexed flatpak repository" ;;
  npm)
    need_cmd npm
    npm cache verify --cache "$STUDIO_ROOT/offline-repo/npm-cache" || warn "npm cache not populated yet"
    log "npm cache verified" ;;
  all)
    "$0" apt || true; "$0" flatpak || true; "$0" npm || true ;;
  *) usage_or_die "usage: create-repository.sh [apt|flatpak|npm|all]" ;;
esac
log "repository index step finished"
