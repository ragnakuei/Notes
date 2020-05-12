# BeginForm

### 指定 Controller / Action

```csharp
@using (Html.BeginForm("someAction", "someController", FormMethod.Get))
{
    ...
}
```

```csharp
@using (Html.BeginForm("someAction", "someController", FormMethod.Post))
{
    ...
}
```

```csharp
@using (Html.BeginForm("Index","Home"))
{
    <input type="submit" value="確定"/>
}
```

### 指定 Url

```csharp
@using (Html.BeginForm(new { 
    action = this.ViewContext.RouteData.Values["action"].ToString() 
}))
{
    @Html.TextBox("Username")

    <input type="submit" />
}
```