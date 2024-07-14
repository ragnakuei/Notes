# Route

二種 routing

-   static routing
-   interactive routing

## [Interactive Route](https://learn.microsoft.com/en-us/aspnet/core/blazor/fundamentals/routing#interactive-routing) 設定方式

App.razor

從

```cs
<Routes />
```

改為

```cs
<Routes @rendermode="InteractiveServer" />
```

或額外指定 prerender

```cs
<Routes @rendermode="new InteractiveServerRenderMode(prerender: true)" />
```
