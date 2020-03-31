# [Blazor Component Lifecycle Diagram](./_files/blazor-component-lifecycle-diagram.pdf)

## [Component initialization methods](https://docs.microsoft.com/zh-tw/aspnet/core/blazor/lifecycle#component-initialization-methods)

## [Before parameters are set](https://docs.microsoft.com/en-us/aspnet/core/blazor/lifecycle#before-parameters-are-set)

## [After parameters are set](https://docs.microsoft.com/en-us/aspnet/core/blazor/lifecycle#after-parameters-are-set)

### 範例

```csharp
@page "/Sample03"

@code
{
    protected override void OnInitialized()
    {
        Console.WriteLine("OnInitialized");
    }

    public override async Task SetParametersAsync(ParameterView parameters)
    {
        Console.WriteLine("SetParametersAsync");
        await base.SetParametersAsync(parameters);
    }

    protected override async Task OnParametersSetAsync()
    {
        Console.WriteLine("OnParametersSetAsync");
    }

    protected override async Task OnAfterRenderAsync(bool firstRender)
    {
        if (firstRender)
        {
            Console.WriteLine("OnAfterRenderAsync firstRender = true");
        }
        Console.WriteLine("OnAfterRenderAsync");
    }

    protected override bool ShouldRender()
    {
        var renderUI = true;
        Console.WriteLine($"ShouldRender renderUI:{renderUI} ");
        return renderUI;
    }

    public void Dispose()
    {
        Console.WriteLine("Dispose");
        // unsubscribe event
    }
}
```

執行結果：

```txt
OnInitialized
OnParametersSetAsync
SetParametersAsync
OnInitialized
OnParametersSetAsync
OnAfterRenderAsync firstRender = true
OnAfterRenderAsync
```
