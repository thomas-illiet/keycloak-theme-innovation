# Configuration

This project ships a local Keycloak setup and a production-ready theme archive. The defaults are designed for development, while the generated JAR is the deployment artifact.

## Environment Variables

Docker Compose accepts these variables:

```bash
KEYCLOAK_VERSION=26.6.2
KEYCLOAK_PORT=8080
KEYCLOAK_ADMIN=admin
KEYCLOAK_ADMIN_PASSWORD=admin
KC_LOG_LEVEL=info
```

The theme application script accepts:

```bash
KEYCLOAK_URL=http://localhost:8080
KEYCLOAK_REALM=ai-innovation
KEYCLOAK_ADMIN=admin
KEYCLOAK_ADMIN_PASSWORD=admin
```

## Theme Selection

The project intentionally ships only these theme types:

```text
login
email
welcome
```

The login and email themes are realm settings:

```bash
/opt/keycloak/bin/kcadm.sh update realms/master -s loginTheme=ai-innovation -s emailTheme=ai-innovation
/opt/keycloak/bin/kcadm.sh update realms/ai-innovation -s loginTheme=ai-innovation -s emailTheme=ai-innovation
```

The welcome theme is a server startup setting:

```bash
--spi-theme--welcome-theme=ai-innovation
```

## Realm Import

The development realm lives at:

```text
realm/ai-innovation-realm.json
```

It configures:

- `loginTheme=ai-innovation`
- `emailTheme=ai-innovation`
- English-only localization
- a public demo OIDC client
- a local demo user

## Development Cache Settings

Docker Compose disables theme caches so edits appear quickly:

```text
--spi-theme--static-max-age=-1
--spi-theme--cache-themes=false
--spi-theme--cache-templates=false
```

Do not use those settings in production.

## Release Target Versions

Use the resolver scripts to control Keycloak targets:

```bash
./scripts/resolve-keycloak-version.sh
./scripts/resolve-keycloak-versions.sh latest-5
./scripts/resolve-keycloak-versions.sh 26.6.2,26.6.1 --json
```

`latest-5` is used by the release workflow so every GitHub release receives artifacts for at least the five latest stable Keycloak versions.
