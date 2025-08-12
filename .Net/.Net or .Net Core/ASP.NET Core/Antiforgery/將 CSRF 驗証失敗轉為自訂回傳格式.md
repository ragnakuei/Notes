# 將 CSRF 驗証失敗轉為自訂回傳格式

目的：為了讓前端統一的 error handler 能有個統一處理的邏輯。

範例語法：

Program.cs

```cs
builder.Services
       .AddControllersWithViews(options =>
                                {
                                    options.Filters.Add<GlobalLogExceptionFilter>();
                                    options.Filters.Add<CustomAntiforgeryValidationFailedResultFilter>();
                                });
```

```cs
/// <summary>
/// 全域 CSRF 驗證失敗結果 Filter
/// </summary>
public class CustomAntiforgeryValidationFailedResultFilter : IAlwaysRunResultFilter
{
    public void OnResultExecuting(ResultExecutingContext context)
    {
        if (context.Result is IAntiforgeryValidationFailedResult)
        {
            context.Result = new ObjectResult(new ErrorResponseDto
                                              {
                                                  ErrorType      = ErrorType.CsrfValidateFailed,
                                                  AlertMessage = "CSRF 驗證失敗，自訂回應",
                                                  ValidateResult = null
                                              })
                             {
                                 StatusCode = StatusCodes.Status400BadRequest
                             };
        }
    }

    public void OnResultExecuted(ResultExecutedContext context) {}
}
```

其中 new ObjectResult() 裡面，可以放該系統統一的錯誤回應格式。
