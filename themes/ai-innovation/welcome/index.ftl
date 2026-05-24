<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="color-scheme" content="light${(properties.darkMode)?boolean?then(' dark', '')}">
    <title>${properties.brandName!'AI Innovation'} Identity</title>
    <link rel="shortcut icon" href="${resourcesPath}/img/favicon.svg">
    <#if properties.darkMode?boolean>
      <script type="module" async blocking="render">
        const DARK_MODE_CLASS = "${properties.kcDarkModeClass}";
        const mediaQuery = window.matchMedia("(prefers-color-scheme: dark)");
        updateDarkMode(mediaQuery.matches);
        mediaQuery.addEventListener("change", (event) => updateDarkMode(event.matches));
        function updateDarkMode(isEnabled) {
          document.documentElement.classList.toggle(DARK_MODE_CLASS, isEnabled);
        }
      </script>
    </#if>
    <#if properties.stylesCommon?has_content>
      <#list properties.stylesCommon?split(' ') as style>
        <link rel="stylesheet" href="${resourcesCommonPath}/${style}">
      </#list>
    </#if>
    <#if properties.styles?has_content>
      <#list properties.styles?split(' ') as style>
        <link rel="stylesheet" href="${resourcesPath}/${style}?v=${properties.themeVersion!'dev'}">
      </#list>
    </#if>
  </head>
  <body data-page-id="welcome">
    <main class="ai-welcome">
      <section class="ai-welcome__hero">
        <header class="ai-welcome__brand">
          <img src="${resourcesPath}/img/logo.svg?v=${properties.themeVersion!'dev'}" alt="${properties.brandName!'AI Innovation'} Identity v2">
        </header>

        <div class="ai-welcome__content">
          <h1>${properties.brandName!'AI Innovation'} Identity</h1>
          <p
            class="ai-welcome__subtitle"
            data-dynamic-subtitle
            data-phrases="Tiny keys for giant ideas.|Your login flow, now with fewer existential questions.|Secure doors, smooth vibes.|Access control with a little sparkle in the circuitry.|Let builders build. Let identity handle the handshake."
            aria-live="polite"
            aria-atomic="true"
          >
            <span class="ai-welcome__subtitle-text">Tiny keys for giant ideas.</span>
          </p>
          <div class="ai-welcome__actions">
            <#if adminConsoleEnabled>
              <a class="pf-v5-c-button pf-m-primary ai-button--admin" href="${adminUrl}">Admin Console</a>
            </#if>
          </div>
        </div>
      </section>

      <#if adminConsoleEnabled && (bootstrap || successMessage?has_content)>
        <section class="ai-welcome__panel" aria-live="polite">
          <#if successMessage?has_content>
            <div class="pf-v5-c-alert pf-m-inline pf-m-success pf-v5-u-mb-lg">
              <div class="pf-v5-c-alert__icon">
                <svg class="pf-v5-svg" viewBox="0 0 512 512" fill="currentColor" aria-hidden="true" role="img" width="1em" height="1em">
                  <path d="M504 256c0 136.967-111.033 248-248 248S8 392.967 8 256 119.033 8 256 8s248 111.033 248 248zM227.314 387.314l184-184c6.248-6.248 6.248-16.379 0-22.627l-22.627-22.627c-6.248-6.249-16.379-6.249-22.628 0L216 308.118l-70.059-70.059c-6.248-6.248-16.379-6.248-22.628 0l-22.627 22.627c-6.248 6.248-6.248 16.379 0 22.627l104 104c6.249 6.249 16.379 6.249 22.628.001z"></path>
                </svg>
              </div>
              <h2 class="pf-v5-c-alert__title">${successMessage}</h2>
            </div>
            <a class="pf-v5-c-button pf-m-primary pf-m-block ai-button--admin" href="${adminUrl}">Admin Console</a>
          </#if>

          <#if bootstrap>
            <#if localUser>
              <h2>Create the first administrator</h2>
              <p>Initialize the local identity instance for AI Innovation.</p>
              <form class="pf-v5-c-form" method="post" novalidate>
                <#if errorMessage?has_content>
                  <div class="pf-v5-c-alert pf-m-inline pf-m-danger pf-v5-u-mb-lg">
                    <div class="pf-v5-c-alert__icon">
                      <svg class="pf-v5-svg" viewBox="0 0 512 512" fill="currentColor" aria-hidden="true" role="img" width="1em" height="1em">
                        <path d="M504 256c0 136.997-111.043 248-248 248S8 392.997 8 256C8 119.083 119.043 8 256 8s248 111.083 248 248zm-248 50c-25.405 0-46 20.595-46 46s20.595 46 46 46 46-20.595 46-46-20.595-46-46-46zm-43.673-165.346l7.418 136c.347 6.364 5.609 11.346 11.982 11.346h48.546c6.373 0 11.635-4.982 11.982-11.346l7.418-136c.375-6.874-5.098-12.654-11.982-12.654h-63.383c-6.884 0-12.356 5.78-11.981 12.654z"></path>
                      </svg>
                    </div>
                    <h3 class="pf-v5-c-alert__title">${errorMessage}</h3>
                  </div>
                </#if>

                <div class="pf-v5-c-form__group">
                  <label class="pf-v5-c-form__label" for="username">
                    <span class="pf-v5-c-form__label-text">Username</span>
                    <span class="pf-v5-c-form__label-required" aria-hidden="true">*</span>
                  </label>
                  <span class="pf-v5-c-form-control pf-m-required">
                    <input id="username" type="text" name="username" autocomplete="username" required>
                  </span>
                </div>

                <div class="pf-v5-c-form__group">
                  <label class="pf-v5-c-form__label" for="password">
                    <span class="pf-v5-c-form__label-text">Password</span>
                    <span class="pf-v5-c-form__label-required" aria-hidden="true">*</span>
                  </label>
                  <span class="pf-v5-c-form-control pf-m-required">
                    <input id="password" type="password" name="password" autocomplete="new-password" required>
                  </span>
                </div>

                <div class="pf-v5-c-form__group">
                  <label class="pf-v5-c-form__label" for="password-confirmation">
                    <span class="pf-v5-c-form__label-text">Password confirmation</span>
                    <span class="pf-v5-c-form__label-required" aria-hidden="true">*</span>
                  </label>
                  <span class="pf-v5-c-form-control pf-m-required">
                    <input id="password-confirmation" type="password" name="passwordConfirmation" autocomplete="new-password" required>
                  </span>
                </div>

                <div class="pf-v5-c-form__group">
                  <label class="pf-v5-c-form__label" for="email">
                    <span class="pf-v5-c-form__label-text">Email</span>
                  </label>
                  <span class="pf-v5-c-form-control">
                    <input id="email" type="email" name="email" autocomplete="email">
                  </span>
                </div>

                <div class="ai-welcome__grid">
                  <div class="pf-v5-c-form__group">
                    <label class="pf-v5-c-form__label" for="firstName">
                      <span class="pf-v5-c-form__label-text">First name</span>
                    </label>
                    <span class="pf-v5-c-form-control">
                      <input id="firstName" type="text" name="firstName" autocomplete="given-name">
                    </span>
                  </div>

                  <div class="pf-v5-c-form__group">
                    <label class="pf-v5-c-form__label" for="lastName">
                      <span class="pf-v5-c-form__label-text">Last name</span>
                    </label>
                    <span class="pf-v5-c-form-control">
                      <input id="lastName" type="text" name="lastName" autocomplete="family-name">
                    </span>
                  </div>
                </div>

                <input name="stateChecker" type="hidden" value="${stateChecker}">
                <button class="pf-v5-c-button pf-m-primary pf-m-block ai-button--create-user" type="submit">Create user</button>
              </form>
            <#else>
              <h2>Local access required</h2>
              <p>Create the administrative user from localhost or with the bootstrap-admin command.</p>
            </#if>
          </#if>
        </section>
      </#if>
    </main>
    <script src="${resourcesPath}/js/ai-innovation-welcome.js?v=${properties.themeVersion!'dev'}"></script>
  </body>
</html>
