# [DI](https://docs.microsoft.com/en-us/aspnet/core/blazor/fundamentals/dependency-injection)

Blazor Server 與 Blazor WebAssembly 的 DI 方式不同 !


### Blazor Server DI 範例

以下二個語法二選一
- 透過 @injet directie
- 在指定的 property 上使用 [Inject] attribute

```cs

```cs
@page "/Edit/{id:guid}"
@inject IManageUserService UserService

<PageTitle>編輯</PageTitle>

<h1>編輯</h1>

<p>
    @Dto.ToJson()
</p>

@code {
    [Inject]
    private IManageUserService UserService { get; set; }

    [Parameter]
    public Guid Id { get; set; }

    private EditDto Dto { get; set; }

    protected override void OnParametersSet()
    {
        Dto = UserService.GetForEdit(Id);
    }
}

```