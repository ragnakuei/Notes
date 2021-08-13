# [HttpHandler](https://docs.microsoft.com/zh-tw/dotnet/api/microsoft.reporting.webforms.httphandler?view=sqlserver-2016)

## 回傳 Json 範例

```csharp
<%@ WebHandler Language="C#" Class="TestError" %>

using System;
using System.Web;
using Newtonsoft.Json;

public class TestError : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";

        var resultDto = new { Message = "Ok" };

        context.Response.Write(JsonConvert.SerializeObject(resultDto));
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