# [Route Parameters](https://docs.microsoft.com/en-us/aspnet/core/blazor/fundamentals/routing#route-parameters)

注意事項：
- 取得 parameter 後，再從 OnParametersSet() 取得相關資料 !

### 範例

```cs
@page "/Edit/{id:guid}"
@inject IManageUserService UserService

<PageTitle>編輯</PageTitle>

<h1>編輯</h1>

<p>
    @Id
</p>

@code {
    [Parameter]
    public Guid Id { get; set; }

    protected override void OnParametersSet()
    {
        // 此時 Id 就會取到值了 !
    }
}

```