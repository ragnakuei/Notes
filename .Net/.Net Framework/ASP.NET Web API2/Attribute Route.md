# Attribute Route

[Route Constraints](https://devblogs.microsoft.com/aspnet/attribute-routing-in-asp-net-mvc-5/#route-constraints)

## Binind QueryString To Array

QueryString

```
api/Values?value=a&value=b
```

Action

```csharp
[HttpPut, Route("api/Values")]
public IHttpActionResult Put([FromUri]string[] value)
{
    return Ok(value);
}
```

## Binind QueryString To Array With Specify Name

QueryString

```
api/Values?v=a&v=b
```

Action

```csharp
[HttpPut, Route("api/Values")]
public IHttpActionResult Put([FromUri(Name = "v")]string[] value)
{
    return Ok(value);
}
```
