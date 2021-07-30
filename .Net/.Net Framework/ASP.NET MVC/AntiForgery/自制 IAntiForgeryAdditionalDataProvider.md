# 自制 IAntiForgeryAdditionalDataProvider

## 範例一

[參考資料](https://stackoverflow.com/questions/24613382/how-to-use-two-antiforgerytoken-in-a-single-page-without-using-the-deprecated-s)

```csharp
public class MyAntiForgeryAdditionalDataProvider : IAntiForgeryAdditionalDataProvider
{
    public string GetAdditionalData(HttpContextBase context)
    {
        return GenerateTokenAndSaveItToTheDB();
    }

    public bool ValidateAdditionalData(HttpContextBase context, string additionalData)
    {
        Guid token = Guid.TryParse(additionalData, out token) ? token : Guid.Empty;
        if (token == Guid.Empty) return false;

        return GetIfTokenIsFoundInTheDBAndNotExpired(token);
    }

    private string GenerateTokenAndSaveItToTheDB()
    {
        var newToken = Guid.NewGuid().ToString();
        //save it to the db
        return newToken;
    }
}
```

Global.asax.cs

```csharp
protected void Application_Start()
{
    AntiForgeryConfig.AdditionalDataProvider = new MyAntiForgeryAdditionalDataProvider();
}
```
