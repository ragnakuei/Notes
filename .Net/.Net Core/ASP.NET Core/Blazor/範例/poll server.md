# poll server

## 每秒更新時間

```csharp
@page "/Sample02"

<p>Now:@(Now)</p>

@code {
    private DateTime? Now;

    protected override async Task OnInitializedAsync()
    {
        var t = new System.Timers.Timer();
        t.Elapsed += async (s, e) =>
        {
            Now = DateTime.Now;
            await InvokeAsync(StateHasChanged);
        };
        t.Interval = 1000;
        t.Start();
    }
}
```
