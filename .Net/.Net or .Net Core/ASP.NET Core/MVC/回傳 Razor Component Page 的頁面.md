# 回傳 Razor Component Page 的頁面

在 .net 8 中介紹的

```cs
public IResult OnGet()
{
    return new RazorCompoentnResult<Home>(new { Message = "Hello from MVC !"});
}
```