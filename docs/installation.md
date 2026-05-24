# Installation

## Requirements

- Docker and Docker Compose.
- `zip` to build the local JAR artifact.
- `curl` and `python3` to resolve Keycloak releases.
- Port `8080` available, or `KEYCLOAK_PORT` set to another port.

## Run Locally

```bash
docker compose up --build
```

The Compose setup:

- builds a Keycloak image with the theme copied into `/opt/keycloak/themes/ai-innovation`;
- mounts `themes/ai-innovation` read-only for fast local iteration;
- imports the `ai-innovation` realm;
- starts Keycloak with the AI Innovation welcome theme;
- disables theme caches for development;
- runs a one-shot `theme-init` service that applies `loginTheme=ai-innovation` and `emailTheme=ai-innovation` to the `master` and `ai-innovation` realms.

Useful URLs:

```text
http://localhost:8080
http://localhost:8080/admin
http://localhost:8080/realms/ai-innovation/protocol/openid-connect/auth?client_id=ai-innovation-app&redirect_uri=http://localhost:3000/&response_type=code&scope=openid
```

## Apply the Theme to an Existing Local Realm

With the local server already running:

```bash
./scripts/apply-theme.sh
```

Available variables:

```bash
KEYCLOAK_URL=http://localhost:8080
KEYCLOAK_ADMIN=admin
KEYCLOAK_ADMIN_PASSWORD=admin
KEYCLOAK_REALM=ai-innovation
```

The script applies:

```text
loginTheme=ai-innovation
emailTheme=ai-innovation
defaultLocale=en
```

to the `master` and `ai-innovation` realms by default. The `welcome` theme remains a server startup parameter:

```bash
--spi-theme--welcome-theme=ai-innovation
```

## Build the JAR

Use the default target:

```bash
./scripts/package-theme.sh
```

Build for the latest stable Keycloak release:

```bash
KEYCLOAK_VERSION="$(./scripts/resolve-keycloak-version.sh)" ./scripts/package-theme.sh
```

Build for the five latest stable Keycloak releases:

```bash
make package-latest-5
```

Resolve the exact versions without building:

```bash
./scripts/resolve-keycloak-versions.sh latest-5
./scripts/resolve-keycloak-versions.sh latest-5 --json
```

Artifacts:

```text
build/ai-innovation-keycloak-theme.jar
build/ai-innovation-keycloak-theme-<KEYCLOAK_VERSION>.jar
build/build-metadata.properties
build/build-metadata-<KEYCLOAK_VERSION>.properties
```

## GitHub Release Artifacts

When a GitHub release is published, the workflow builds a matrix for the five latest stable Keycloak versions and uploads these assets to the release:

```text
ai-innovation-keycloak-theme-<KEYCLOAK_VERSION>.jar
SHA256SUMS
```

Existing release assets with the same names are replaced.

## Production Deployment

Typical deployment:

```bash
cp build/ai-innovation-keycloak-theme.jar /opt/keycloak/providers/
/opt/keycloak/bin/kc.sh build
/opt/keycloak/bin/kc.sh start --spi-theme--welcome-theme=ai-innovation
```

Then set the realm themes:

```bash
/opt/keycloak/bin/kcadm.sh update realms/master -s loginTheme=ai-innovation -s emailTheme=ai-innovation
/opt/keycloak/bin/kcadm.sh update realms/ai-innovation -s loginTheme=ai-innovation -s emailTheme=ai-innovation -s defaultLocale=en
```

## Production Cache Settings

Do not use these development options in production:

```text
--spi-theme--static-max-age=-1
--spi-theme--cache-themes=false
--spi-theme--cache-templates=false
```

They are useful locally, but they reduce performance.
