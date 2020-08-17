# [SendGrid](https://app.sendgrid.com/)

## 註冊步驟

1. 前往官網註冊帳號
1. 開啟 Settings
1. 選擇 Sender Authentication
1. 建立 Single Sender Verification
    1. `From Email Address` 跟 `Reply To` 都填自己
    1. 公司資訊都填寫詳細
1. 寄發驗証信，點擊驗証信內的連結，驗証成功 (可能需要嘗試多次)

## C

安裝[套件](https://github.com/sendgrid/sendgrid-csharp#prerequisites) `SendGrid`

-   From 要設定申請的 email

```csharp
public class SendGridMailService : ISendMailService
{
    private string _apiKey;

    private MailSettingDto _mailSetting;

    private SendGridClient _client;

    private EmailAddress _from;

    public SendGridMailService(IConfiguration configuration)
    {
        _apiKey = configuration.GetSection(AppSettingsKey.SendGridApiKey).Value;

        _mailSetting = new MailSettingDto
                        {
                            FromName    = configuration.GetSection(AppSettingsKey.MailFromName).Value,
                            FromAddress = configuration.GetSection(AppSettingsKey.MailFromAddress).Value,
                        };

        _client = new SendGridClient(_apiKey);

        _from = new EmailAddress(_mailSetting.FromAddress, _mailSetting.FromName);
    }

    public async Task SendForgetPasswordEmailAsync(UserInfoDto userInfoDto, string resetPasswordHyperLink)
    {
        var subject = "密碼重置信";
        var to      = new EmailAddress(userInfoDto.Email, userInfoDto.Name);
        var plainTextContent = $@"請點擊下面連結以重置密碼
{ resetPasswordHyperLink }";

        var htmlContent = "<strong>and easy to do anywhere, even with C#</strong>";

        // 如果有給定 htmlContent，就不會套用 plainTextContent
        var msg = MailHelper.CreateSingleEmail(_from, to, subject, plainTextContent, htmlContent);

        await _client.SendEmailAsync(msg);
    }
}
```
