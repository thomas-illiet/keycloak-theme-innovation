<#macro emailLayout>
<!doctype html>
<html lang="${locale.language}" dir="${(ltr)?then('ltr','rtl')}">
  <body style="margin:0;padding:0;background:#07110f;color:#10201d;font-family:Arial,Helvetica,sans-serif;">
    <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="background:#07110f;background-image:linear-gradient(135deg,#07110f,#10201d 52%,#14251f);padding:32px 12px;">
      <tr>
        <td align="center">
          <table role="presentation" width="100%" cellspacing="0" cellpadding="0" style="max-width:620px;background:#ffffff;border:1px solid rgba(184,242,95,0.24);border-radius:8px;overflow:hidden;">
            <tr>
              <td style="background:#07110f;background-image:linear-gradient(135deg,#07110f,#10201d 52%,#14251f);padding:28px 32px;border-bottom:4px solid #2dd4bf;">
                <div style="color:#e7f0ec;font-size:24px;font-weight:800;letter-spacing:0;">${properties.brandName!'AI Innovation'}</div>
                <div style="width:96px;height:3px;margin-top:12px;background:#2dd4bf;line-height:3px;font-size:3px;">&nbsp;</div>
                <div style="margin-top:12px;color:#b8f25f;font-size:13px;font-weight:700;">${properties.brandTagline!'Trusted access for intelligent products'}</div>
              </td>
            </tr>
            <tr>
              <td style="padding:30px 32px;font-size:16px;line-height:1.6;">
                <style>
                  .ai-mail-button {
                    display: inline-block;
                    padding: 12px 18px;
                    color: #eef7f4 !important;
                    background: #0f766e;
                    border-radius: 8px;
                    font-weight: 700;
                    text-decoration: none;
                  }
                </style>
                <#nested>
              </td>
            </tr>
            <tr>
              <td style="padding:18px 32px;background:#f7fbfa;color:#65736f;font-size:12px;line-height:1.5;border-top:1px solid #dce8e4;">
                ${properties.brandName!'AI Innovation'} Identity
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </body>
</html>
</#macro>
