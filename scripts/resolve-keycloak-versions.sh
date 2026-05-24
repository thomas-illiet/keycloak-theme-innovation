#!/usr/bin/env sh
set -eu

SELECTOR="${KEYCLOAK_VERSIONS:-${KEYCLOAK_VERSION:-latest}}"
FORMAT="text"

for arg in "$@"; do
  case "$arg" in
    --json)
      FORMAT="json"
      ;;
    *)
      SELECTOR="$arg"
      ;;
  esac
done

api_get() {
  if [ -n "${GITHUB_TOKEN:-}" ]; then
    curl -fsSL \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer $GITHUB_TOKEN" \
      "$1"
  else
    curl -fsSL \
      -H "Accept: application/vnd.github+json" \
      "$1"
  fi
}

print_versions() {
  if [ "$FORMAT" = "json" ]; then
    python3 -c 'import json,sys; print(json.dumps([line.strip() for line in sys.stdin if line.strip()]))'
  else
    cat
  fi
}

case "$SELECTOR" in
  latest)
    COUNT=1
    ;;
  latest-*)
    COUNT="${SELECTOR#latest-}"
    case "$COUNT" in
      ''|*[!0-9]*)
        echo "Invalid latest selector: $SELECTOR" >&2
        exit 1
        ;;
    esac
    if [ "$COUNT" -lt 1 ]; then
      echo "Latest selector count must be greater than zero: $SELECTOR" >&2
      exit 1
    fi
    ;;
  *)
    printf '%s\n' "$SELECTOR" \
      | tr ',' '\n' \
      | python3 -c 'import sys
seen = set()
for raw in sys.stdin:
    version = raw.strip().lstrip("v")
    if version and version not in seen:
        seen.add(version)
        print(version)
' \
      | print_versions
    exit 0
    ;;
esac

api_get "https://api.github.com/repos/keycloak/keycloak/releases?per_page=100" \
  | python3 -c 'import json, re, sys
count = int(sys.argv[1])
versions = []
seen = set()
for release in json.load(sys.stdin):
    if release.get("draft") or release.get("prerelease"):
        continue
    tag = str(release.get("tag_name", "")).lstrip("v")
    if not re.match(r"^\d+\.\d+\.\d+$", tag):
        continue
    if tag in seen:
        continue
    seen.add(tag)
    versions.append(tag)
    if len(versions) == count:
        break
if len(versions) < count:
    raise SystemExit(f"Expected {count} stable Keycloak releases, found {len(versions)}")
print("\n".join(versions))
' "$COUNT" \
  | print_versions
