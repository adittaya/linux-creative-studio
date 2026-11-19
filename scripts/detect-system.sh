#!/usr/bin/env bash
# Detect distribution, architecture, glibc and tool availability. Emits JSON on stdout.
set -euo pipefail
STUDIO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

jstr() { python3 -c 'import json,sys; print(json.dumps(sys.argv[1]))' "$1"; }

ID="unknown"; VERSION_ID="unknown"; VERSION_CODENAME="unknown"; PRETTY="unknown"
if [[ -r /etc/os-release ]]; then
  # shellcheck disable=SC1091
  . /etc/os-release
  ID="${ID:-unknown}"; VERSION_ID="${VERSION_ID:-unknown}"
  VERSION_CODENAME="${VERSION_CODENAME:-${UBUNTU_CODENAME:-unknown}}"
  PRETTY="${PRETTY_NAME:-unknown}"
fi

ARCH="$(uname -m)"
case "$ARCH" in
  x86_64|amd64) NORMAL_ARCH="x86_64" ;;
  aarch64|arm64) NORMAL_ARCH="aarch64" ;;
  *) NORMAL_ARCH="$ARCH" ;;
esac

GLIBC="unknown"
if command -v ldd >/dev/null 2>&1; then
  GLIBC="$(ldd --version 2>&1 | head -1 | grep -oE '[0-9]+\.[0-9]+' | head -1 || true)"
fi
[[ -n "$GLIBC" ]] || GLIBC="unknown"

PKGMGR="unknown"
for m in apt dnf yum pacman zypper apk; do
  if command -v "$m" >/dev/null 2>&1; then PKGMGR="$m"; break; fi
done

SUPPORTED=false
case "$ID:$NORMAL_ARCH" in
  debian:x86_64|debian:aarch64|ubuntu:x86_64|ubuntu:aarch64|linuxmint:x86_64|linuxmint:aarch64) SUPPORTED=true ;;
esac

TOOLS=()
for t in python3 bash git curl wget jq ffmpeg ffprobe flatpak docker podman npm node sha256sum gpg apt apt-get; do
  command -v "$t" >/dev/null 2>&1 && TOOLS+=("$t")
done

python3 - "$ID" "$VERSION_ID" "$VERSION_CODENAME" "$PRETTY" "$NORMAL_ARCH" "$GLIBC" "$PKGMGR" "$SUPPORTED" "${TOOLS[@]}" <<'PY'
import json, sys, platform
(id_, ver, codename, pretty, arch, glibc, pmgr, supported, *tools) = sys.argv[1:]
print(json.dumps({
    "distro": {"id": id_, "version": ver, "codename": codename, "pretty_name": pretty},
    "architecture": arch,
    "kernel": platform.release(),
    "glibc": glibc,
    "package_manager": pmgr,
    "target_supported": supported == "true",
    "available_tools": tools,
    "recommended_method": ("apt-repository-snapshot" if pmgr == "apt" else "portable-archive-or-flatpak"),
    "caveats": [
        "Compatibility is not proven by detection alone; run scripts/verify.sh and tests/.",
        "Do not replace system glibc, Python or graphics drivers to satisfy an application."
    ],
    "studio_root": __import__('os').environ.get('STUDIO_ROOT', ''),
}, indent=2))
PY
