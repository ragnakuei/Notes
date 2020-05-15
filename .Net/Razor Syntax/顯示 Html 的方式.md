# 顯示 Html 的方式

### 套用 Html

```html
@{
    <text><h1>234</h1></text>
}

@{
    @:<h1>345</h1>
}
```

### 不套用 Html

```csharp
@{
	string i = "<h1>123</h1>";
}

<span>@Html.Raw(i)</span>
```