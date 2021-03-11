# Service Account

-   適用於 Web Server
-   進入 Google API Console
    -   以下範例都使用相同一組的 Google Account
    -   建立 Credentials
    -   選擇 Service Account
    -   Service Account 建立完畢後
        -   在 Service Account 內建立 Private Key
            -   Key 建立的當下，就會同時下載對應的 json 檔
        -   獲得一組 Service Account 專門的 Email Account
            -   格式範例：xxxx@yyyyy.gserviceaccount.com
            -   將這個 Email Account 加到 Google Calendar 的權限中
                -   權限至少要大於等於 `Make changes to events`
    -   可以透過以下程式去透過 Google Calendar API 來建立 Event

參考資料

-   [Google Calendar API Authentication with C#](https://www.daimto.com/google-calendar-api-authentication-with-c/)

## 指定 Service Account Priavte Key Json 檔

-   搭配[參考範例](../OAuth2/.Net%20實作.md)
    -   以下面的語法替換上述範例中的 GetUserCredential() 就可以了
-   serviceAccountKeyFile 就是 Key 建立的當下，同時下載的 json 檔路徑

```csharp
private async Task<GoogleCredential> GetGoogleCredential()
{
    var serviceAccountKeyFilePath = new List<string> { _pathService.GetBaseDirectory() }
                                    .Concat(_configuration.GetArray(AppSettingsKey.GoogleServiceAccount))
                                    .ToArray();

    var serviceAccountKeyFile = Path.Combine(serviceAccountKeyFilePath);

    using (var stream = new FileStream(serviceAccountKeyFile, FileMode.Open, FileAccess.Read))
    {
        var credential = GoogleCredential.FromStream(stream)
                                            .CreateScoped(Scopes);

        return await Task.FromResult(credential);
    }
}
```

## 手動指定 Priavte Key

-   搭配[參考範例](../OAuth2/.Net%20實作.md)
    -   以下面的語法替換上述範例中的 GetUserCredential() 就可以了
-   xxxx@yyyyy.gserviceaccount.com 就是 Service Account 專門的 Email Account
-   FromPrivateKey() 的來源在於 Key 建立的當下，同時下載的 json 檔中的 `private_key` 所提供的

```csharp
private async Task<ServiceAccountCredential> GetServiceAccountCredential()
{
    var initializer = new ServiceAccountCredential.Initializer("xxxx@yyyyy.gserviceaccount.com")
                        {
                            Scopes = Scopes,
                        }.FromPrivateKey("-----BEGIN PRIVATE KEY-----\nxxxxxxxxxxxxxxxxx\n-----END PRIVATE KEY-----\n");

    var credential = new ServiceAccountCredential( initializer );

    return await Task.FromResult(credential);
}
```
