# 註冊 HttpHandler

[How to: Register HTTP Handlers](https://docs.microsoft.com/en-us/previous-versions/aspnet/46c5ddfy(v=vs.100))

## 範例

### 建立繼承 `IHttpHandler` 的 class

```csharp
public class CountHttpHandler : IHttpHandler
{
    public static int gCountRequest = 0;
    public void ProcessRequest(HttpContext context)
    {
        gCountRequest++;
        context.Response.Write(string.Format("<script>alert('CountRequest = {0} ');</script>", gCountRequest));
        context.Response.End();
     }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}
```

### 註冊至 Web.config

在 namespace `HandlerExample.MyHttpHandler` 建立 `HandlerTest` 的 class

```xml
<configuration>
   <system.web>
      <httpHandlers>
         <add verb="*" path="handler.aspx" type="HandlerExample.MyHttpHandler,HandlerTest"/>
      </httpHandlers>
   </system.web>
</configuration>
```