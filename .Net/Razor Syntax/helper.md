# helper

通常用來搭配 Html 做為 Template使用，如果是單純的 C# Method 功能，可以試試 [function](https://www.notion.so/function-87fb8c79884249449dad2560beb43758)

```csharp
@helper GetValue(DAL.Entities.Group group)
{
    <thead>
    <tr>
        <th>@Html.Display(p => p.Id)</th>
        <th>@Html.Display(p => p.Name)</th>
        <th>@Html.DisplayForModel()</th>
    </tr>
    </thead>
}
```