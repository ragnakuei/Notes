# Lifecycle

順序

進入頁面

-   SetParametersAsync
-   OnInitialized{Async}
-   OnParametersSet{Async}
-   子組件 SetParametersAsync
-   子組件 OnInitialized{Async}
-   子組件 OnParametersSet{Async}
-   OnAfterRender{Async}
-   子組件 OnAfterRender{Async}

經過 Interactive ( 例：設定 原組件 field 及 子組件 Parameter )

-   子組件 SetParametersAsync
-   子組件 OnParametersSet{Async}
-   OnAfterRender{Async}
-   子組件 OnAfterRender{Async}

---

在 static route 設定下

> 不管用哪種方式進入 interactive 頁面，都會發生 Lifecycle Events 執行二次的狀況 !

其中，依照 [進入頁面的方式](./進入頁面的方式.md) 方式的不同有不同的情況：

> 只有 直接輸入 url / 重新整理頁面 這個方式可以讓 PersistentComponentState 的機制運作正常 !
> 而 internal navigation 則無法讓 PersistentComponentState 的機制以預的方式來運作 !

在 interactive route & 最正確的設定下

> 透過 internal navigation 進入頁面時，只會執行一次 Lifecycle Events，而且不需要 PersistentComponentState !
> 透過 直接輸入 url / 重新整理頁面 進入頁面時，會分別以 Prerender / Rerender 方式各執行一次 Lifecycle Events，而且 PersistentComponentState 機制運作是正常的 !

---

Lifecycle Events 第一次執行，官方稱之為 [Prerender](./Prerender.md) 階段

有 Prerender 階段執行後的 Lifecycle Events 第二次執行，我個人稱之為 Rerender 階段，會正式 Render 頁面所有內容 !

> 在 Prerender 階段完成後，Rerender 會在 SignalR 連線成功後，才開始執行 !
> [In a Blazor Web App, interactive server-side rendering (interactive SSR), which operates over a SignalR connection with the client]

Rerender 不會再次經過 OnInitialized{Async}

> 經過 Interfactive 的更新順序，大致上跟進入頁面相同，其餘依照當下的情境，來視情況是否需要呼叫 Lifecycle Events

---

Event{Async} 還是要呼叫
> await base.Event{Async}(parameters);

---

避免重複執行 Lifecycle Events 而導致重複撈取資料 [Persist prerendered state]

```cs
@page "/lifecycle/PersistPrerenderedState"
@inject ILogger<PersistPrerenderedState> Logger
@inject PersistentComponentState         ApplicationState
@implements IDisposable

@code {
    private int?   _value;
    private Random r = new();

    private PersistingComponentStateSubscription? _persistingSubscription;
    private string                                ApplicationStateKey = "Value";

    public override async Task SetParametersAsync(ParameterView parameters)
    {
        Logger.LogInformation("SetParametersAsync");

        await base.SetParametersAsync(parameters);
    }

    protected override void OnInitialized()
    {
        _persistingSubscription = ApplicationState.RegisterOnPersisting(async () =>
                                                                        {
                                                                            ApplicationState.PersistAsJson(ApplicationStateKey, _value);
                                                                        });

        if (!ApplicationState.TryTakeFromJson<int>(ApplicationStateKey, out var restoredValue))
        {
            _value = r.Next(1, 100);
            Logger.LogInformation("OnInitialized value: {_value}", _value);
        }
        else
        {
            _value = restoredValue!;
            Logger.LogInformation("OnInitialized Restore value: {_value}", _value);
        }
    }

    public void Dispose()
    {
        Logger.LogInformation("Dispose");
        _persistingSubscription?.Dispose();
    }

}

<h2>PersistPrerenderedState</h2>
<div>
    Value: @_value
</div>
```

避免 Lifecycle Events 不想被呼叫 & 又想要 render mode interactive 時，可以把 prerender 設定為 false，可以參考 [Prerender](./Prerender.md)
