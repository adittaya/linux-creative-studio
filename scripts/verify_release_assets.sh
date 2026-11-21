#!/usr/bin/env bash
set -euo pipefail
SUMS="${1:-release/SHA256SUMS.txt}"
DIR="${2:-release-assets}"
(cd "$DIR" && sha256sum -c "../$SUMS" --ignore-missing)
