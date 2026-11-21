#!/usr/bin/env bash
set -euo pipefail
REPO="${1:-adittaya/linux-creative-studio}"
TAG="${2:-reverse-engineering-offline-packages}"
OUT="${3:-release-assets}"
mkdir -p "$OUT"
gh release download "$TAG" --repo "$REPO" -D "$OUT"
