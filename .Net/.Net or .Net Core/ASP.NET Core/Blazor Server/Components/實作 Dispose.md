# 實作 Dispose

```cs
@page "/test"

// 要記得繼承 IDisposable 
@implements IDisposable

@code {
    protected override void OnInitialized()
    {
        // 進入此 component 時，就會執行 !
    }

    public void Dispose()
    {
        // 離開此 component 時，就會執行 !
    }
}
```