#!/usr/bin/env bash
# Shared library for all studio scripts. Source only; never execute directly.
set -euo pipefail

STUDIO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_DIR="$STUDIO_ROOT/logs"
mkdir -p "$LOG_DIR"
LOG_FILE="${STUDIO_LOG_FILE:-$LOG_DIR/studio.log}"
DRY_RUN="${DRY_RUN:-0}"

log() { printf '[%s] %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$*" | tee -a "$LOG_FILE"; }
warn() { printf '[%s] WARN: %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$*" | tee -a "$LOG_FILE" >&2; }
die() { printf '[%s] ERROR: %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$*" | tee -a "$LOG_FILE" >&2; exit 1; }

need_cmd() { command -v "$1" >/dev/null 2>&1 || die "required command not found: $1"; }

check_root_fs() {
  local min_gb="${MIN_FREE_GB:-5}" avail
  avail=$(df -Pm "$STUDIO_ROOT" | awk 'NR==2 {print $4}')
  [[ "$avail" -gt $((min_gb * 1024)) ]] || die "less than ${min_gb} GB free on studio filesystem"
}

in_studio() {
  case "$(readlink -f "$1" 2>/dev/null || true)" in
    "$STUDIO_ROOT"/*) return 0 ;;
    *) return 1 ;;
  esac
}

safe_copy() {
  local src="$1" dst="$2"
  in_studio "$dst" || die "refusing to write outside studio: $dst"
  [[ "$DRY_RUN" == "1" ]] && { log "dry-run: cp $src -> $dst"; return 0; }
  mkdir -p "$(dirname "$dst")"
  cp -f -- "$src" "$dst"
}

verify_sha256() {
  local file="$1" expected="$2"
  need_cmd sha256sum
  local actual
  actual=$(sha256sum "$file" | awk '{print $1}')
  [[ "$actual" == "$expected" ]] || die "SHA-256 mismatch for $file (expected $expected, got $actual)"
  log "SHA-256 verified: $file"
}

usage_or_die() { die "${1:-invalid arguments}"; }
