# Architecture

## Theme Scope

The repository is centered on one Keycloak theme named `ai-innovation`.

```text
themes/ai-innovation/
  login/
  email/
  welcome/
```

It does not include `account` or `admin` themes. Modern Keycloak account and admin consoles are separate applications with a different customization model.

## Login Theme

The login theme inherits from the official `keycloak.v2` parent:

```properties
parent=keycloak.v2
import=common/keycloak
```

This keeps the custom theme compatible with Keycloak-managed login flows such as:

- sign in
- registration
- reset credentials
- OTP
- WebAuthn and passkeys
- identity providers
- required actions
- error states

The custom files focus on visual identity:

```text
login/resources/css/ai-innovation-login.css
login/resources/css/ai-innovation-background.css
login/messages/messages_en.properties
login/error.ftl
login/footer.ftl
```

## Welcome Theme

The welcome theme is self-contained:

```text
welcome/index.ftl
welcome/resources/css/ai-innovation-welcome.css
welcome/resources/js/ai-innovation-welcome.js
welcome/resources/img/logo.svg
```

It provides the branded landing page, the dynamic subtitle, and the local bootstrap administrator form when Keycloak exposes it.

## Shared Visual System

Login and welcome share identical background assets:

```text
login/resources/css/ai-innovation-background.css
welcome/resources/css/ai-innovation-background.css
login/resources/img/ai-lattice.svg
welcome/resources/img/ai-lattice.svg
```

`scripts/validate-theme.sh` checks that these files stay identical. This keeps the two pages visually aligned even though Keycloak serves resources from separate theme type folders.

## Email Theme

The email theme uses a minimal wrapper:

```text
email/html/template.ftl
email/messages/messages_en.properties
```

Email clients do not reliably support modern CSS or animation, so the email design uses static inline styles and the same color language as the web surfaces.

## Packaging

The JAR structure follows Keycloak provider discovery:

```text
META-INF/keycloak-themes.json
theme/ai-innovation/
```

`scripts/package-theme.sh` copies the theme and descriptor into `build/package`, zips them, then creates:

```text
build/ai-innovation-keycloak-theme.jar
build/ai-innovation-keycloak-theme-<KEYCLOAK_VERSION>.jar
build/build-metadata.properties
build/build-metadata-<KEYCLOAK_VERSION>.properties
```

The versioned JAR is used for release assets.
