# 回傳 Razor Component Page 的頁面

在 .net 8 中介紹的

```cs
app.Map("/Test", () => new RazorComponentResult<Home(new { Message = "Hello from Minimal API!" }));
```