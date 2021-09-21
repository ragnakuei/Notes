# 判斷是否已經在處理 Response

## 範例

正常流程

-   asp.net core web api 專案
-   middleware 依照下面的順序執行
-   當 controller / action 中，執行到錯誤時
-   首先會被 下面的 middleware 攔截
-   當下面的 middleware 執行完畢後， context.Response.HasStarted 就會從 false 改為 true

```csharp
app.Use(async (context, next) =>
{
    try
    {
        await next();
    }
    catch (Exception ex)
    {
        // 可以透過 context.Response.HasStarted 來判斷 response 是否已經給定了
        // if (context.Response.HasStarted == false)
        // {
            context.Response.StatusCode  = (int)HttpStatusCode.InternalServerError;
            context.Response.ContentType = "application/json";

            await context.Response.WriteAsync(new
                                                {
                                                    Message = ex.Message,
                                                }.ToJson());
        // }

        Debug.WriteLine("TryCatch2");

        throw ex;
    }
});

app.Use(async (context, next) =>
{
    try
    {
        await next();
    }
    catch (Exception ex)
    {
        if (context.Response.HasStarted == false)
        {
            context.Response.StatusCode  = (int)HttpStatusCode.InternalServerError;
            context.Response.ContentType = "application/json";

            await context.Response.WriteAsync(new
                                                {
                                                    Message = ex.Message,
                                                }.ToJson());

            // throw ex;    // 情境討論流程:往外層的 middleware 拋出例外
        }

        Debug.WriteLine("TryCatch1");
    }
});
```

情境討論流程

-   當下面的 middleware 執行完畢後，再拋出一個 exception
-   context.Response.HasStarted 仍然會從 false 改為 true
-   接下來由上面的 middleware 來執行
-   當經過下面的 middleware 處理過 response 後，如果在上面的 middleware，要再處理一次 response，就會出現以下訊息至 Debug Output 中
    > System.InvalidOperationException: StatusCode cannot be set because the response has already started.
-   此時，就可以透過 context.Response.HasStarted 來判斷 response 是否已經給定了，來避免重複或不必要的處理 !
