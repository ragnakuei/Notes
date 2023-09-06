# PageLink

#### 顯示指定的 Page File 的 Url

| 專案路徑                 | 套用 PageLink                |
| ------------------------ | ---------------------------- |
| /Pages/Test/Index.cshtml | @Url.PageLink("/Test/Index") |
|                          |                              |

#### 套用 QueryString

要記得給定 argument name values !

```cs
var no = Context.Request.Query["no"];
var url = Url.PageLink("/test/a01", values : new { no })
```
