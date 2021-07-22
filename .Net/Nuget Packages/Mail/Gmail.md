# Gmail

參考資料：
- https://dotblogs.com.tw/chichiBlog/2018/04/20/122816
- https://blog.user.today/gmail-smtp-authentication-required/


## 開啟 https://www.google.com/settings/security/lesssecureapps

https://www.google.com/settings/security/lesssecureapps


## 語法

```csharp
public class SendEmailDto
{
    /// <summary>
    /// 收件者s
    /// </summary>
    public List<MailAddress> Tos { get; set; }

    /// <summary>
    /// 主旨
    /// </summary>
    public string Subject { get; set; }

    /// <summary>
    /// 純文字信件內容
    /// </summary>
    public string PlainTextContent { get; set; }

    /// <summary>
    /// Html 信件內容
    /// </summary>
    public string HtmlContent { get; set; }
}
```

- "email account 就是申請的 gmail 信箱帳號

```csharp
public abstract class BaseSendMailService
{
    protected readonly MailAddress _from;


    protected BaseSendMailService()
    {
        _from = new MailAddress("email account", Utility.GetAppSettings("Mail_FromName"));
    }

    /// <summary>
    /// 發送信件
    /// </summary>
    public abstract Task SendMailAsync(SendEmailDto dto);
}

public class GmailService : BaseSendMailService
{
    public override async Task SendMailAsync(SendEmailDto dto)
    {
        using (var mail = new MailMessage())
        {
            mail.From = _from;

            foreach (var to in dto.Tos)
            {
                mail.To.Add(to);
            }

            mail.Priority = MailPriority.Normal;
            mail.Subject  = dto.Subject;

            if (dto.HtmlContent.IsNullOrWhiteSpace())
            {
                mail.Body       = dto.PlainTextContent;
                mail.IsBodyHtml = false;
            }
            else
            {
                mail.Body       = dto.HtmlContent;
                mail.IsBodyHtml = true;
            }

            var gmailSmtp = new SmtpClient("smtp.gmail.com", 587);
            gmailSmtp.Credentials = new System.Net.NetworkCredential("email account", "email password");
            gmailSmtp.EnableSsl   = true;

            gmailSmtp.Send(mail);

            await Task.FromResult(0);
        }
    }
}
```

信件寄出後，會於 Gmail 寄件備份留下記錄 !


## 套用至二階段驗証的帳號


