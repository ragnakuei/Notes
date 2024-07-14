# Prerender

參考資料

-   https://learn.microsoft.com/en-us/aspnet/core/blazor/components/prerender

### Prerender 設計的用意

-   改善 SEO

    -   在爬蟲角度看 html 原始碼的情況下，其實不需要提供 event handler，也不會建立 SignalR 連線，所以在 SignalR 建立連線前，不會提供該頁 event handler 的功能 !

    -   讓頁面內的 <HeadContent></HeadContent> 可以 render 至 <HeadOutlet /> 功能
        因為 Rerender 階段不會處理 SEO 相關功能 !

### 觸發時機

只在 request 完整頁面時，所以 internal navigation 不會觸發 prerender !

### Prerender 設定方式

1. [route 要調整為 interactive route](./Route.md#interactive-route-設定方式)，並指定 prerender 為 true
   等於直接設定所有頁面的 render mode 為 interactive !
1. 該頁面直接指定 render mode 並指定 prerender 為 true

### 關閉 Prerender 的方式

避免 Lifecycle Events 不想被呼叫 & 又想要 render mode interactive 時，可以把 prerender 設定為 false，會造成 [HeadOutlet | HeadContent](./HeadOutlet%20|%20HeadContent.md) 無對應的階段可以執行 !

設定方式

-   全域設定

    ```cs
    <Routes @rendermode="new InteractiveServerRenderMode(prerender: false)" />
    ```

-   指定頁面上以 directive 設定

    ```cs
    @rendermode @(new InteractiveServerRenderMode(prerender: false))
    ```
