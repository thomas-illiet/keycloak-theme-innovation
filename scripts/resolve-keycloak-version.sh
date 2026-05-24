#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

"$ROOT_DIR/scripts/resolve-keycloak-versions.sh" "${KEYCLOAK_VERSION:-latest}" \
  | sed -n '1p'
