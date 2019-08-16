# 驗証 Sample

使用 MessageHandler 做第一時間驗証  

```csharp
public class ValidAppIdSecret : DelegatingHandler
{
    protected override async Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
    {
        var bodyJson = await request.Content.ReadAsStringAsync();
        var body = JsonConvert.DeserializeObject<AppIdScretToken>(bodyJson);

        IToken tokenService = new DataBaseToken();
        if (tokenService.Validation(body) == false)
        {
            return new HttpResponseMessage(HttpStatusCode.BadRequest)
            {
                Content = new StringContent("驗證不通過!")
            };
        }

        return await base.SendAsync(request, cancellationToken);
    }

}
```
