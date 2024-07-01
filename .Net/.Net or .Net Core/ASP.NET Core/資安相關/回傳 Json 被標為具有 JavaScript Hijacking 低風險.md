# 回傳 Json 被標為具有 JavaScript Hijacking 低風險

原先的寫法：

```cs
return Json(data);

return new JsonResult(data);
```

預計的解法：

```cs
[HttpPost]
[Consumes("application/json")]
[Produces("application/json")]
public IActionResult GetXXX()
{
    var data = _xxxService.GetXXX();
    return Ok(data);
}
```

可能的解法：

從 Dapper 取出的 DTO ，要經過轉型成另一個 DTO 後，再回傳 !
