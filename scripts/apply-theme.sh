#!/usr/bin/env sh
set -eu

SERVER_URL="${KEYCLOAK_URL:-http://localhost:8080}"
ADMIN_USER="${KEYCLOAK_ADMIN:-admin}"
ADMIN_PASSWORD="${KEYCLOAK_ADMIN_PASSWORD:-admin}"
REALM="${KEYCLOAK_REALM:-ai-innovation}"

docker compose exec keycloak /opt/keycloak/bin/kcadm.sh config credentials \
  --server "$SERVER_URL" \
  --realm master \
  --user "$ADMIN_USER" \
  --password "$ADMIN_PASSWORD"

docker compose exec keycloak /opt/keycloak/bin/kcadm.sh update "realms/$REALM" \
  -s loginTheme=ai-innovation \
  -s emailTheme=ai-innovation \
  -s internationalizationEnabled=true \
  -s defaultLocale=en

docker compose exec keycloak /opt/keycloak/bin/kcadm.sh update realms/master \
  -s loginTheme=ai-innovation \
  -s emailTheme=ai-innovation

echo "Applied login and email themes to realms: master, $REALM"
echo "The welcome theme is configured at server startup with --spi-theme--welcome-theme=ai-innovation."
