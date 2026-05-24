# Customization

## Colors and Visual System

Main styles:

```text
themes/ai-innovation/login/resources/css/ai-innovation-background.css
themes/ai-innovation/login/resources/css/ai-innovation-login.css
themes/ai-innovation/welcome/resources/css/ai-innovation-background.css
themes/ai-innovation/welcome/resources/css/ai-innovation-welcome.css
```

Core variables:

```css
--ai-bg: #07110f;
--ai-cyan: #2dd4bf;
--ai-lime: #b8f25f;
--ai-amber: #f5b84b;
```

## Text

Login and welcome labels:

```text
themes/ai-innovation/login/messages/messages_en.properties
themes/ai-innovation/welcome/messages/messages_en.properties
```

Email text:

```text
themes/ai-innovation/email/messages/messages_en.properties
```

This project is English-only. If you add more languages, remember that Java `.properties` message formatting requires single quotes to be escaped as doubled quotes:

```properties
doForgotPassword=Reset users'' access
```

## Welcome Subtitle

The welcome page rotates several short subtitle phrases:

```text
themes/ai-innovation/welcome/index.ftl
themes/ai-innovation/welcome/resources/js/ai-innovation-welcome.js
```

Edit the `data-phrases` attribute in `welcome/index.ftl`. Separate phrases with `|`.

## Templates

Provided templates:

```text
login/error.ftl
login/footer.ftl
email/html/template.ftl
welcome/index.ftl
```

Other login pages inherit from the official `keycloak.v2` parent. This keeps newer Keycloak flows compatible, including OTP, WebAuthn, passkeys, identity providers, password reset, required actions and error states.

## Assets

Main assets:

```text
login/resources/img/ai-lattice.svg
welcome/resources/img/ai-lattice.svg
welcome/resources/img/logo.svg
```

To change the welcome logo, replace `welcome/resources/img/logo.svg`.

Login and welcome intentionally use identical background files:

```text
login/resources/css/ai-innovation-background.css
welcome/resources/css/ai-innovation-background.css
login/resources/img/ai-lattice.svg
welcome/resources/img/ai-lattice.svg
```

If you change the background, update both copies together. `scripts/validate-theme.sh` checks that they stay identical.

## Add a Locale

The theme currently supports only English:

```properties
locales=en
```

To add another locale:

1. Add the locale to `login/theme.properties`, `email/theme.properties` and `welcome/theme.properties`.
2. Create the matching `messages/messages_xx.properties` files.
3. Add the locale to the realm import or configure it in Keycloak.
4. Update `scripts/validate-theme.sh` if you intentionally add non-English bundles.

Example:

```properties
locales=en,es
```

## Scope

This project intentionally does not provide `account` or `admin` themes. Modern Keycloak Account and Admin consoles are React applications and have a different customization lifecycle.
