# helper

> Asp.Net Core 3.1 已取消 Helper 語法

通常用來搭配 Html 做為 Template 使用，如果是單純的 C# Method 功能，可以試試 [function](https://www.notion.so/function-87fb8c79884249449dad2560beb43758)

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

## [Global Helper](https://docs.microsoft.com/en-us/aspnet/web-pages/overview/ui-layouts-and-themes/creating-and-using-a-helper-in-an-aspnet-web-pages-site)

在 `App_Code` 中建立 `MyHelper.cshtml`

```csharp
@helper GenerateUl()
{
    <ul>

    </ul>
}
```

就可以在各個 View 中以下面語法來呼叫

```html
@MyHelper.GenerateUl()
```

## Global Functions

在 `App_Code` 中建立 `MyHelper.cshtml`

```csharp
@functions
{
    public static string Test()
    {
        return string.Empty;
    }
}
```

就可以在各個 View 中以下面語法來呼叫

```html
@App_Code_Helpers.Test()
```
