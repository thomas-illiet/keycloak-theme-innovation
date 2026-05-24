<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
  <#if section = "header">
    ${kcSanitize(msg("errorTitleHtml"))?no_esc}
  <#elseif section = "form">
    <div id="kc-error-message" class="ai-error">
      <div class="ai-error__signal" aria-hidden="true"></div>
      <p class="instruction">${kcSanitize(message.summary)?no_esc}</p>
      <#if traceId??>
        <p class="instruction" id="traceId">${msg("traceIdSupportMessage", traceId)}</p>
      </#if>
      <p class="ai-error__helper">${msg("aiInnovation.error.helper")}</p>
      <#if skipLink??>
      <#else>
        <#if client?? && client.baseUrl?has_content>
          <p><a id="backToApplication" class="${properties.kcButtonSecondaryClass} ${properties.kcButtonBlockClass}" href="${client.baseUrl}">${msg("backToApplication")}</a></p>
        </#if>
      </#if>
    </div>
  </#if>
</@layout.registrationLayout>

