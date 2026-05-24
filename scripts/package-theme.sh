#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
BUILD_DIR="$ROOT_DIR/build"
PACKAGE_DIR="$BUILD_DIR/package"
KEYCLOAK_VERSION="${KEYCLOAK_VERSION:-26.6.2}"
OUTPUT="$BUILD_DIR/ai-innovation-keycloak-theme.jar"
VERSIONED_OUTPUT="$BUILD_DIR/ai-innovation-keycloak-theme-$KEYCLOAK_VERSION.jar"

rm -rf "$PACKAGE_DIR"
mkdir -p "$PACKAGE_DIR/META-INF" "$PACKAGE_DIR/theme" "$BUILD_DIR"

cp "$ROOT_DIR/META-INF/keycloak-themes.json" "$PACKAGE_DIR/META-INF/keycloak-themes.json"
cp -R "$ROOT_DIR/themes/ai-innovation" "$PACKAGE_DIR/theme/ai-innovation"

rm -f "$OUTPUT" "$VERSIONED_OUTPUT"
(
  cd "$PACKAGE_DIR"
  zip -qr "$OUTPUT" META-INF theme
)

cp "$OUTPUT" "$VERSIONED_OUTPUT"

echo "Theme archive created: $OUTPUT"
echo "Versioned archive created: $VERSIONED_OUTPUT"

cat > "$BUILD_DIR/build-metadata.properties" <<EOF
themeName=ai-innovation
keycloakVersion=$KEYCLOAK_VERSION
artifact=$VERSIONED_OUTPUT
EOF

cp "$BUILD_DIR/build-metadata.properties" "$BUILD_DIR/build-metadata-$KEYCLOAK_VERSION.properties"
