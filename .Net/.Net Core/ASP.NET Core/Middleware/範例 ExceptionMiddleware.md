# 範例 ExceptionMiddleware

注意

> Middleware 裡面不可以 DI 非系統的物件
> 因為系統物件註冊的時機較早

## IApplicationBuilder Extension

```csharp
public static class ExceptionMiddlewareExtensions
{
    public static void ConfigureCustomExceptionMiddleware(this IApplicationBuilder app)
    {
        app.UseMiddleware<ExceptionMiddleware>();
    }
}
```

## Startup.Configure()

```csharp
app.ConfigureCustomExceptionMiddleware();
```

## ExceptionMiddleware

```csharp
public class ExceptionMiddleware
{
    private readonly RequestDelegate _next;

    private readonly ILogger<ExceptionMiddleware> _logger;

    private readonly IMemoryCache _memoryCache;

    public ExceptionMiddleware(RequestDelegate              next,
                                ILogger<ExceptionMiddleware> logger,
                                IMemoryCache                 memoryCache)
    {
        _logger      = logger;
        _memoryCache = memoryCache;
        _next        = next;
    }

    public async Task InvokeAsync(HttpContext httpContext)
    {
        try
        {
            await _next(httpContext);
        }
        catch (ValidateFormFailedException ex)
        {
            await HandleValidateFormFailedExceptionAsync(httpContext, ex);
        }
        catch (ErrorCodeException ex)
        {
            await HandleErrorCodeExceptionAsync(httpContext, ex);
        }
        catch (BadHttpRequestException ex)
        {
            await HandleBadHttpRequestExceptionAsync(httpContext, ex);
        }
        catch (Exception ex)
        {
            await HandleExceptionAsync(httpContext, ex);
        }
    }

    #region ValidateFormFailedException

    private Task HandleValidateFormFailedExceptionAsync(HttpContext context, ValidateFormFailedException ex)
    {
        _logger.LogError(ex.GetLogMessages());

        context.Response.ContentType = "application/json";
        context.Response.StatusCode  = (int)HttpStatusCode.BadRequest;

        var validateResultMessage = ValidateFormFailedToAlertString(ex);

        return context.Response.WriteAsync(new ResponseDto
                                            {
                                                Message   = validateResultMessage,
                                                ErrorCode = ErrorCode.E400003,
                                            }.ToJson());
    }

    /// <summary>
    /// 將驗証失敗的資料轉成 string，讓前端的 alert 來顯示
    /// </summary>
    private string ValidateFormFailedToAlertString(ValidateFormFailedException ex)
    {
        var propertiesDisplayNames = GetPropertiesDisplayNames(ex.DataType);

        var result = new StringBuilder();
        result.AppendLine("欄位驗証失敗");
        result.AppendLine("--------------------------------------");

        // 因為 ModelState 產生的欄位錯誤訊息順序不一定，所以順序由 反射 來決定
        foreach (var property in propertiesDisplayNames)
        {
            var modelStateByProperty = ex.ModelState.GetValueOrDefault(property.Key);
            if (modelStateByProperty.Errors.Count == 0)
            {
                continue;
            }

            result.AppendLine($"欄位:{property.Value}");

            foreach (var errorMessage in modelStateByProperty.Errors)
            {
                result.AppendLine($"- {errorMessage.ErrorMessage}");
            }
        }

        return result.ToString();
    }

    private Dictionary<string, string> GetPropertiesDisplayNames(Type type)
    {
        var cacheKey = $"ValidateFormFailedException_{type.Name}";

        var result = _memoryCache.Get<Dictionary<string, string>>(cacheKey);

        if (result != null)
        {
            return result;
        }

        result = type.GetProperties()
                        .Select(p => new
                                    {
                                        PropertyName     = p.Name,
                                        DisplayAttribute = p.GetCustomAttributes(typeof(DisplayAttribute), false)?.FirstOrDefault() as DisplayAttribute
                                    })
                        .Where(x => x.DisplayAttribute != null)
                        .ToDictionary(k => k.PropertyName, v => v.DisplayAttribute.Name);

        _memoryCache.Set(cacheKey, result);

        return result;
    }

    #endregion

    private Task HandleErrorCodeExceptionAsync(HttpContext context, ErrorCodeException ex)
    {
        _logger.LogError(ex.GetLogMessages());

        context.Response.ContentType = "application/json";
        context.Response.StatusCode  = (int)HttpStatusCode.InternalServerError;

        return context.Response.WriteAsync(new ResponseDto
                                            {
                                                Message   = ex.Message,
                                                ErrorCode = ex.ErrorCode,
                                                Data      = ex.Data
                                            }.ToJson());
    }

    private Task HandleBadHttpRequestExceptionAsync(HttpContext context, BadHttpRequestException ex)
    {
        if (ex.Message == SystemExceptionMessage.RequestBodyTooLarge)
        {
            return HandleErrorCodeExceptionAsync(context, new ErrorCodeException(ErrorCode.E400006));
        }

        return HandleExceptionAsync(context, ex);
    }

    private Task HandleExceptionAsync(HttpContext context, Exception ex)
    {
        _logger.LogError(ex.GetLogMessages());

        context.Response.ContentType = "application/json";
        context.Response.StatusCode  = (int)HttpStatusCode.InternalServerError;

        return context.Response.WriteAsync(new ResponseDto()
                                            {
                                                Message = "發生錯誤，請聯絡系統管理員 !"
                                            }.ToJson());
    }
}

```

### FormDto

```csharp
public class FormDto<T>
{
    public ModelStateDictionary ModelState { get; set; }

    public PageInfoDto PageInfo { get; set; }

    public T Data { get; set; }

    public void Validate()
    {
        if (ModelState.IsValid == false)
        {
            throw new ValidateFormFailedException
                    {
                        ModelState = ModelState,
                        DataType   = typeof(CreateAccountFormDto),
                    };
        }
    }
}
```

### ValidateFormFailedException

```csharp
public class ValidateFormFailedException : Exception
{
    public ModelStateDictionary ModelState { get; set; }

    public Type DataType { get; set; }
}
```

### ErrorCodeException

可搭配 ErrorCode

> throw new ErrorCodeException(ErrorCode.E400001);

```csharp
public class ErrorCodeException : Exception
{
    public ErrorCodeException(int errorCode)
    : base(Parameters.ErrorCode.GetErrorMessage(errorCode))
    {
        ErrorCode = errorCode;
    }

    public int ErrorCode { get; set; }

    public object Data { get; set; }
}
```

### ErrorCode

```csharp
public class ErrorCode
{
    public static string GetErrorMessage(int errorCode)
    {
        var errorMessage = _errorMessages.GetValue(errorCode);

        if (string.IsNullOrWhiteSpace(errorMessage))
        {
            throw new NotSupportedException();
        }

        return errorMessage;
    }

    /// <summary>
    /// 驗證碼輸入不正確
    /// </summary>
    public static int E400001 => 400001;

    /// <summary>
    /// 帳號或密碼輸入不正確
    /// </summary>
    public static int E400002 => 400002;

    /// <summary>
    /// 表單驗証失敗
    /// </summary>
    public static int E400003 => 400003;

    /// <summary>
    /// 找不到對應的使用者資料
    /// </summary>
    public static int E400004 => 400004;

    /// <summary>
    /// 查無帳號
    /// </summary>
    public static int E400005 => 400005;

    /// <summary>
    /// Request Body 超出指定容量
    /// </summary>
    public static int E400006 => 400006;

    /// <summary>
    /// 上傳檔案超過指定大小
    /// </summary>
    public static int E400007 => 400007;

    /// <summary>
    /// 上傳檔案有誤，請重新上傳
    /// </summary>
    public static int E400008 => 400008;

    /// <summary>
    /// Cache Key 為空
    /// </summary>
    public static int E400009 => 400009;

    private static Dictionary<int, string> _errorMessages
        = new Dictionary<int, string>
            {
                [E400001] = "驗證碼輸入不正確",
                [E400002] = "帳號或密碼輸入不正確",
                [E400003] = "表單驗証失敗",
                [E400004] = "找不到對應的使用者資料",
                [E400005] = "查無帳號",
                [E400006] = "Request Body 超出指定容量",
                [E400007] = "上傳檔案超過指定大小",
                [E400008] = "上傳檔案有誤，請重新上傳",
                [E400009] = "Cache Key 為空",
            };
}
```
