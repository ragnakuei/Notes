# template syntax

原本在 asp.net mvc 使用的的是 @functions 及 @helper

但是在 asp.net core mvc 上，已取消了 @helper directive 了 !

## functions 範例

在 `@functions { }` 的宣告上，用 `@{ }` 似乎也是可以，但 Rider 會無法判讀 !

```csharp
<nav>
    @if (User.IsInRole(RoleConst.Manager))
    {
        // 用法一
        await ManagerNavAsync();
    }
    else if (User.IsInRole(RoleConst.Engineer))
    {
        // 用法二
        @EngineerNav().Invoke(null)
    }
</nav>
```

### functions 用法一

待確認：只要 functions 內的 method 有用到 Tag Helper ，就必須要改成 async / await 語法 !

-   [改成 async / await 語法後，會有 build warning](https://github.com/dotnet/aspnetcore/issues/20055)

```csharp
@functions {
    async Task ManagerNavAsync()
    {
        <div>
            <p>
                <a asp-controller="Vender"
                   asp-action="Index">
                    AA
                </a>
                <a>
                    BB
                </a>
                <a>
                    CC
                </a>
                <a>
                    DD
                </a>
                <a>
                    EE
                </a>
                <a>
                    FF
                </a>
                <a asp-controller="Home"
                   asp-action="Manager">
                    Home
                </a>
                <a asp-controller="User"
                   asp-action="Index">
                    User
                </a>
            </p>
            <p>
                <a asp-controller="ManageAccount"
                   asp-action="Index">
                    ManageAccount
                </a>
                <a asp-controller="ManageAccount"
                   asp-action="Create">
                    CreateAccount
                </a>
            </p>
        </div>
    }
}
```

### functions 用法二

使用這種語法時，要注意 output 只能有一個 root dom

```csharp
@functions {
    Func<dynamic, IHtmlContent> EngineerNav() =>
    @<div>
        <p>
            <a asp-controller="Home"
                asp-action="Engineer">
                Home
            </a>
            <a asp-controller="User"
                asp-action="Index">
                User
            </a>
        </p>
        <p>
            <a asp-controller="Engineer"
                asp-action="AssignDate">
                AssignDate
            </a>
        </p>
    </div>;
}
```

### functions 用法三

```csharp
<div>
    @GenerateName(item)
</div>
```

```csharp
@functions
{
    string GenerateName(Dto dto)
    {
        if (string.IsNullOrWhiteSpace(dto.EngineerName))
        {
            return "指派";
        }
        else
        {
            return "重新指派";
        }
    }
}
```
