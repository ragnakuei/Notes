# 讀取 Form 的資料 不包含 IFormFile

Startup.cs

```csharp
app.UseMiddleware<TestMiddleware>();
```

Middleware

```csharp
public class TestMiddleware
{
    public TestMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    private readonly RequestDelegate _next;

    public async Task Invoke(HttpContext context)
    {
        if (context.Request.HasJsonContentType())
        {
            
        }

        if (context.Request.HasFormContentType)
        {
            // 這邊取出的 FormCollection 不會包含 IFormFile 的資料
            var forms = context.Request.Form;
        }

        await _next(context);
    }
}
```

ViewModel

```csharp
public class ViewModel
{
    public string Name { get; set; }

    public IFormFile[] Files { get; set; }
}
```

View

```html
@model TestMvcUploadFile.Controllers.ViewModel
<form asp-action="Index"
      enctype="multipart/form-data">
    <input asp-for="Name" />
    <hr />
    <p>
        <input type="file"
               asp-for="Files" />
    </p>
    <p>
        <input type="file"
               asp-for="Files" />
    </p>

    <p>
        <button type="submit">送出</button>
    </p>
</form>
```