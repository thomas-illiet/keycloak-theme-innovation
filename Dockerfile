ARG KEYCLOAK_VERSION=26.6.2
FROM quay.io/keycloak/keycloak:${KEYCLOAK_VERSION}

COPY --chown=keycloak:keycloak themes/ai-innovation /opt/keycloak/themes/ai-innovation
COPY --chown=keycloak:keycloak realm/ai-innovation-realm.json /opt/keycloak/data/import/ai-innovation-realm.json
