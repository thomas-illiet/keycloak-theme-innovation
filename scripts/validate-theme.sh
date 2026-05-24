#!/usr/bin/env sh
set -eu

ROOT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
THEME_DIR="$ROOT_DIR/themes/ai-innovation"
FAILED=0

require_file() {
  if [ ! -f "$1" ]; then
    echo "Missing file: $1"
    FAILED=1
  fi
}

require_dir() {
  if [ ! -d "$1" ]; then
    echo "Missing directory: $1"
    FAILED=1
  fi
}

require_dir "$THEME_DIR/login"
require_dir "$THEME_DIR/email"
require_dir "$THEME_DIR/welcome"

require_file "$THEME_DIR/login/theme.properties"
require_file "$THEME_DIR/login/resources/css/ai-innovation-background.css"
require_file "$THEME_DIR/login/resources/css/ai-innovation-login.css"
require_file "$THEME_DIR/login/resources/img/ai-lattice.svg"
require_file "$THEME_DIR/login/error.ftl"
require_file "$THEME_DIR/login/footer.ftl"
require_file "$THEME_DIR/login/messages/messages_en.properties"
require_file "$THEME_DIR/email/theme.properties"
require_file "$THEME_DIR/email/html/template.ftl"
require_file "$THEME_DIR/email/messages/messages_en.properties"
require_file "$THEME_DIR/welcome/theme.properties"
require_file "$THEME_DIR/welcome/index.ftl"
require_file "$THEME_DIR/welcome/messages/messages_en.properties"
require_file "$THEME_DIR/welcome/resources/css/ai-innovation-background.css"
require_file "$THEME_DIR/welcome/resources/js/ai-innovation-welcome.js"
require_file "$THEME_DIR/welcome/resources/img/ai-lattice.svg"
require_file "$ROOT_DIR/META-INF/keycloak-themes.json"
require_file "$ROOT_DIR/realm/ai-innovation-realm.json"

if [ -d "$THEME_DIR/account" ] || [ -d "$THEME_DIR/admin" ]; then
  echo "Unexpected account/admin theme directory found. This project intentionally ships only login, email and welcome."
  FAILED=1
fi

if grep -Eq '"(account|admin)"' "$ROOT_DIR/META-INF/keycloak-themes.json"; then
  echo "Unexpected account/admin type in META-INF/keycloak-themes.json"
  FAILED=1
fi

if grep -Eq '"(accountTheme|adminTheme)"' "$ROOT_DIR/realm/ai-innovation-realm.json"; then
  echo "Unexpected account/admin theme setting in realm import"
  FAILED=1
fi

if grep -q 'msg(' "$THEME_DIR/welcome/index.ftl"; then
  echo "Do not use msg(...) in welcome/index.ftl; Keycloak welcome templates do not expose that helper."
  FAILED=1
fi

if grep -q 'Keycloak theme' "$THEME_DIR/welcome/index.ftl"; then
  echo "Do not show 'Keycloak theme' on the welcome page."
  FAILED=1
fi

if find "$THEME_DIR" -path '*/messages/messages_fr.properties' -print -quit | grep -q .; then
  echo "Unexpected French message bundle found. This theme is English-only."
  FAILED=1
fi

if grep -Rqs 'locales=.*fr' "$THEME_DIR"; then
  echo "Unexpected French locale configured. This theme is English-only."
  FAILED=1
fi

if grep -Eq '"fr"|"defaultLocale": "fr"' "$ROOT_DIR/realm/ai-innovation-realm.json"; then
  echo "Unexpected French locale in realm import. This project defaults to English."
  FAILED=1
fi

if ! cmp -s "$THEME_DIR/login/resources/css/ai-innovation-background.css" "$THEME_DIR/welcome/resources/css/ai-innovation-background.css"; then
  echo "Login and welcome background CSS must stay identical."
  FAILED=1
fi

if ! cmp -s "$THEME_DIR/login/resources/img/ai-lattice.svg" "$THEME_DIR/welcome/resources/img/ai-lattice.svg"; then
  echo "Login and welcome lattice SVG must stay identical."
  FAILED=1
fi

if [ "$FAILED" -ne 0 ]; then
  exit 1
fi

echo "Theme structure is valid."
