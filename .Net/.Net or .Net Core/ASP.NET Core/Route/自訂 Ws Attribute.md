# 自訂 Ws Attribute

## 概述

這是一個自訂的 ASP.NET Core 路由約定，用於簡化 WebSocket 端點的定義。透過自訂的 `[WS]` Attribute 和 `WsRoutingConvention`，可以讓 WebSocket 端點的路由配置更加直觀和一致。

## 使用場景

- 當專案中有多個 WebSocket 端點時，希望統一管理和命名規範
- 需要將所有 WebSocket 路由自動加上 `ws/` 前綴以區分一般 HTTP 路由
- 想要支援類似 MVC 的 `{controller}` 和 `{action}` 路由佔位符

## 設定方式

### Program.cs

在 `Program.cs` 中註冊自訂的路由約定：

```cs
builder.Services.AddControllersWithViews(options =>
{
    options.Conventions.Add(new WsRoutingConvention());
});
```

這個設定會讓所有 Controller 中標記了 `[WS]` Attribute 的 Action 方法自動套用 WebSocket 路由約定。

## 使用範例

### Controller 中的 WebSocket 端點

```cs
[WS("{controller}/WebSocket03")]
public async Task WebSocket03Handler()
{
    if (HttpContext.WebSockets.IsWebSocketRequest)
    {
        using var webSocket = await HttpContext.WebSockets.AcceptWebSocketAsync();
        await _sampleService.HandleWebSocket03ConnectionAsync(webSocket);
    }
    else
    {
        HttpContext.Response.StatusCode = StatusCodes.Status400BadRequest;
    }
}
```

### 路由解析說明

實際上 Api Endpoint 為 `/ws/Product/WebSocket03`，因為 `WSAttribute` 會自動加上 `ws/` 前綴。

**路由解析過程：**
1. 原始模板：`{controller}/WebSocket03`
2. 替換 `{controller}` 為實際的 Controller 名稱（如 `Product`）：`Product/WebSocket03`
3. 自動加上 `ws/` 前綴：`ws/Product/WebSocket03`

**其他使用方式：**
- `[WS]`：無參數，會使用預設路由 `ws/{controller}/{action}`
- `[WS("custom-path")]`：自訂路徑，會自動加上 `ws/` 前綴變成 `ws/custom-path`
- `[WS("{controller}/{action}")]`：使用佔位符，支援動態替換

## 實作細節

### WSAttribute 類別

```cs
/// <summary>
/// 用來標示 Action 是 WebSocket 端點
/// </summary>
[AttributeUsage(AttributeTargets.Method)]
public class WSAttribute : Attribute
{
    public string? Template { get; set; }

    public WSAttribute()
    {
    }

    public WSAttribute(string template)
    {
        Template = template;
    }
}
```

**設計說明：**
- `AttributeUsage(AttributeTargets.Method)`：限制此 Attribute 只能用在方法上
- `Template` 屬性：允許自訂路由模板，支援 `{controller}` 和 `{action}` 佔位符
- 提供無參數和有參數兩種建構子，增加使用彈性

### WsRoutingConvention 類別

```cs
/// <summary>
/// WebSocket 路由約定
/// 處理帶有 [WS] Attribute 的 Action，自動加上 ws 前綴並支援路由模板
/// </summary>
public class WsRoutingConvention : IControllerModelConvention
{
    public void Apply(ControllerModel controller)
    {
        // 如果該 controller 以 abstract 宣告，則略過
        if (controller.ControllerType.IsAbstract)
            return;

        // 處理每個 Action
        foreach (var action in controller.Actions)
        {
            var wsAttribute = action.ActionMethod
                .GetCustomAttributes(typeof(WSAttribute), false)
                .FirstOrDefault() as WSAttribute;

            if (wsAttribute == null)
                continue;

            // 建立 WebSocket 路由模板
            var routeTemplate = BuildRouteTemplate(wsAttribute, controller, action);

            var attributeRouteModel = new AttributeRouteModel
            {
                Template = routeTemplate
            };

            // 新增或設定路由
            if (action.Selectors.Count == 1 
                && action.Selectors[0].AttributeRouteModel == null)
            {
                action.Selectors[0].AttributeRouteModel = attributeRouteModel;
            }
            else
            {
                action.Selectors.Add(new SelectorModel
                {
                    AttributeRouteModel = attributeRouteModel
                });
            }
        }
    }

    private string BuildRouteTemplate(WSAttribute wsAttribute, ControllerModel controller, ActionModel action)
    {
        string template;

        if (!string.IsNullOrEmpty(wsAttribute.Template))
        {
            // 如果有指定模板，進行替換
            template = wsAttribute.Template
                .Replace("{controller}", controller.ControllerName, StringComparison.OrdinalIgnoreCase)
                .Replace("{action}", action.ActionName, StringComparison.OrdinalIgnoreCase);
        }
        else
        {
            // 預設模板：ws/{controller}/{action}
            template = $"ws/{controller.ControllerName}/{action.ActionName}";
        }

        // 確保以 ws 開頭
        if (!template.StartsWith("ws/", StringComparison.OrdinalIgnoreCase))
        {
            template = "ws/" + template;
        }

        return template;
    }
}
```

**運作機制說明：**

1. **Apply 方法**：
   - 實作 `IControllerModelConvention` 介面，在應用程式啟動時自動被呼叫
   - 過濾掉 abstract Controller，避免處理基底類別
   - 遍歷每個 Action，尋找標記了 `[WS]` 的方法
   - 為符合條件的 Action 建立並設定路由模板

2. **BuildRouteTemplate 方法**：
   - 處理路由模板的建立邏輯
   - 支援 `{controller}` 和 `{action}` 佔位符的動態替換
   - 如果沒有指定模板，使用預設格式：`ws/{controller}/{action}`
   - 確保所有路由都以 `ws/` 開頭，統一 WebSocket 端點的命名規範

3. **路由設定策略**：
   - 如果 Action 只有一個 Selector 且尚未設定路由，直接設定
   - 否則新增一個 Selector，允許同一個 Action 有多個路由（例如同時支援 HTTP 和 WebSocket）

## 注意事項

1. **WebSocket 中介軟體**：需要在 `Program.cs` 中啟用 WebSocket 支援：
   ```cs
   app.UseWebSockets();
   ```

2. **Controller 名稱**：`{controller}` 佔位符會自動移除 "Controller" 後綴。例如 `ProductController` 會變成 `Product`

3. **大小寫**：路由替換時使用 `OrdinalIgnoreCase`，不區分大小寫

4. **路由衝突**：確保 WebSocket 路由不與現有的 HTTP 路由衝突，使用 `ws/` 前綴可有效避免此問題

5. **Abstract Controller**：標記為 abstract 的 Controller 會被自動忽略，適合用於定義基底類別

## 優點

- **統一管理**：所有 WebSocket 端點都有統一的路由前綴和命名規範
- **簡化配置**：使用 Attribute 標記，程式碼更簡潔易讀
- **彈性設計**：支援自訂路由模板和佔位符替換
- **易於維護**：集中管理路由邏輯，修改時只需調整 Convention 類別
- **避免衝突**：自動加上 `ws/` 前綴，與一般 HTTP 路由明確區分

## 使用場景範例

```cs
public class ChatController : ControllerBase
{
    // 路由：ws/Chat/Room
    [WS]
    public async Task Room() { /* ... */ }
    
    // 路由：ws/Chat/live-chat
    [WS("live-chat")]
    public async Task LiveChat() { /* ... */ }
    
    // 路由：ws/Chat/room/123
    [WS("{controller}/room/{id}")]
    public async Task RoomWithId(string id) { /* ... */ }
}
