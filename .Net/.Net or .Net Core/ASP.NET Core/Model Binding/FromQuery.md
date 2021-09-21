# FromQuery 

## 前端給的 QueryString 不包含 []

URL

```
https://localhost:44311/Home/Test?ids=1&ids=2&ids=3
```

後端只要這樣寫就可以了 

```csharp
[HttpGet,Route("Home/Test")]
public IActionResult Test([FromQuery] string[] ids)
{
    return Json(ids);
}
```


## 前端給的 QueryString 必須包含 []

URL

```
https://localhost:44311/Home/Test?ids[]=1&ids[]=2&ids[]=3
```

後端 FromQuery 指定 Name 做特定解析就可以了 !

```csharp
[HttpGet,Route("Home/Test")]
public IActionResult Test([FromQuery(Name = "ids[]")] string[] ids)
{
    return Json(ids);
}
```

