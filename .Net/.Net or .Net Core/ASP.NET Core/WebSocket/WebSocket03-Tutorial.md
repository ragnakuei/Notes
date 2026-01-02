# ASP.NET Core WebSocket 跨 Session 共用範例（聊天室）

## 📋 目錄

- [概述](#概述)
- [功能特色](#功能特色)
- [技術架構](#技術架構)
- [實作步驟](#實作步驟)
  - [1. Controller 設定](#1-controller-設定)
  - [2. Service 層實作](#2-service-層實作)
  - [3. 前端 View 實作](#3-前端-view-實作)
  - [4. JavaScript 實作](#4-javascript-實作)
- [訊息格式](#訊息格式)
- [核心機制](#核心機制)
- [使用方式](#使用方式)
- [技術要點](#技術要點)
- [完整程式碼](#完整程式碼)

---

## 概述

WebSocket03 是一個完整的聊天室應用範例，展示如何使用 ASP.NET Core WebSocket 實現**跨 Session 的即時通訊**。與前面的範例不同，此範例支援多個客戶端同時連線，並能將訊息廣播給所有連線的用戶。

### 主要特點

- ✅ 支援多用戶同時連線
- ✅ 訊息即時廣播給所有用戶
- ✅ 支援多種訊息類型（文字、圖片、音訊、影片、檔案）
- ✅ 顯示用戶加入/離開通知
- ✅ 顯示線上人數統計
- ✅ 自動管理連線生命週期

---

## 功能特色

### 1. 跨 Session 通訊
- 使用 `ConcurrentDictionary` 儲存所有活動連線
- 每個連線都有唯一的 ID
- 訊息可廣播給所有連線的客戶端

### 2. 多類型訊息支援
- **文字訊息**：一般文字內容
- **圖片訊息**：支援 jpg、png、gif 等格式
- **音訊訊息**：支援 mp3、wav 等格式
- **影片訊息**：支援 mp4、webm 等格式
- **檔案訊息**：支援各種檔案類型
- **系統訊息**：用戶加入/離開通知

### 3. 連線管理
- 自動分配連線 ID
- 追蹤線上人數
- 自動清理斷線的連線
- 發送歡迎訊息

### 4. 大檔案支援
- 使用 64KB 緩衝區
- 支援分段接收訊息
- Base64 編碼傳輸檔案

---

## 技術架構

```
┌─────────────┐         WebSocket          ┌──────────────────┐
│  Client 1   │◄─────────────────────────►│                  │
├─────────────┤                             │                  │
│  Client 2   │◄─────────────────────────►│   ASP.NET Core   │
├─────────────┤         Broadcast          │   WebSocket      │
│  Client 3   │◄─────────────────────────►│      Server      │
└─────────────┘                             │                  │
                                            └──────────────────┘
                                                     │
                                                     ▼
                                            ┌──────────────────┐
                                            │ ConcurrentDict   │
                                            │ <ID, WebSocket>  │
                                            └──────────────────┘
```

### 主要組件

1. **Controller** (`SampleController.cs`)
   - 路由設定
   - WebSocket 請求驗證
   - 將連線轉交給 Service 處理

2. **Service** (`SampleService.cs`)
   - 連線管理（ConcurrentDictionary）
   - 訊息廣播邏輯
   - 訊息處理和解析

3. **View** (`WebSocket03.cshtml`)
   - 使用者介面
   - 連線狀態顯示
   - 訊息輸入與顯示

4. **JavaScript** (`websocket03.js`)
   - WebSocket 客戶端邏輯
   - 訊息傳送與接收
   - 檔案處理（Base64 編碼）

---

## 實作步驟

### 1. Controller 設定

在 Controller 中設定 WebSocket 路由和處理器：

```csharp
public class SampleController : Controller
{
    private readonly ISampleService _sampleService;

    public SampleController(ISampleService sampleService)
    {
        _sampleService = sampleService;
    }

    // 顯示聊天室頁面
    public IActionResult WebSocket03()
    {
        return View();
    }

    // WebSocket 連線端點
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
}
```

**說明**：
- `[WS]` 屬性用於標記 WebSocket 路由，會將該 Action 額外在 Api Endpoint 加上 ws 的前置詞。可參考 [自訂%20Ws%20Attribute](../Route/自訂%20Ws%20Attribute.md)。
- 驗證請求是否為 WebSocket 請求
- 接受 WebSocket 連線並轉交給 Service 處理

---

### 2. Service 層實作

#### 2.1 連線管理

```csharp
public class SampleService : ISampleService
{
    // 靜態字典用於跨 Session 共用連線
    private static readonly ConcurrentDictionary<string, WebSocket> _webSocket03Connections = new();
    private static int _connectionIdCounter = 0;

    public async Task HandleWebSocket03ConnectionAsync(WebSocket webSocket)
    {
        // 生成唯一連線 ID
        var connectionId = $"Client_{Interlocked.Increment(ref _connectionIdCounter)}_{Guid.NewGuid():N}";
        
        // 將連線加入字典
        _webSocket03Connections.TryAdd(connectionId, webSocket);

        try
        {
            // 發送歡迎訊息
            await SendWelcomeMessage(webSocket, connectionId);
            
            // 廣播用戶加入通知
            await BroadcastUserJoined(connectionId);
            
            // 開始接收訊息
            await ReceiveMessages(webSocket, connectionId);
        }
        finally
        {
            // 清理連線
            _webSocket03Connections.TryRemove(connectionId, out _);
            await BroadcastUserLeft(connectionId);
        }
    }
}
```

**關鍵技術**：
- `ConcurrentDictionary`：執行緒安全的字典，用於多執行緒環境
- `Interlocked.Increment`：原子操作，確保連線 ID 唯一
- `static` 欄位：跨 Session 共用資料

#### 2.2 訊息接收處理

```csharp
private async Task ReceiveMessages(WebSocket webSocket, string connectionId)
{
    var buffer = new byte[1024 * 64]; // 64KB 緩衝區

    while (webSocket.State == WebSocketState.Open)
    {
        using var memoryStream = new MemoryStream();
        WebSocketReceiveResult result;

        // 接收完整訊息（可能分段）
        do
        {
            result = await webSocket.ReceiveAsync(
                new ArraySegment<byte>(buffer),
                CancellationToken.None);
            
            memoryStream.Write(buffer, 0, result.Count);
        }
        while (!result.EndOfMessage);

        if (result.MessageType == WebSocketMessageType.Text)
        {
            // 解析 JSON 訊息
            var messageJson = Encoding.UTF8.GetString(memoryStream.ToArray());
            var message = JsonSerializer.Deserialize<MessageObject>(messageJson);

            if (message != null)
            {
                message.Sender = connectionId;
                message.Timestamp = DateTime.Now;
                
                // 廣播給所有用戶
                await BroadcastMessageAsync(message);
            }
        }
        else if (result.MessageType == WebSocketMessageType.Close)
        {
            await webSocket.CloseAsync(
                WebSocketCloseStatus.NormalClosure,
                "關閉連線",
                CancellationToken.None);
        }
    }
}
```

**技術要點**：
- 使用 `MemoryStream` 組合分段訊息
- 支援大型訊息傳輸
- `EndOfMessage` 標記用於判斷訊息完整性

#### 2.3 廣播機制

```csharp
private async Task BroadcastMessageAsync(MessageObject message, string? excludeConnectionId = null)
{
    var messageJson = JsonSerializer.Serialize(message, new JsonSerializerOptions
    {
        PropertyNamingPolicy = JsonNamingPolicy.CamelCase
    });
    var messageBytes = Encoding.UTF8.GetBytes(messageJson);

    var tasks = new List<Task>();

    foreach (var kvp in _webSocket03Connections)
    {
        // 可選擇排除特定連線（例如發送者）
        if (excludeConnectionId != null && kvp.Key == excludeConnectionId)
            continue;

        var clientSocket = kvp.Value;

        if (clientSocket.State == WebSocketState.Open)
        {
            tasks.Add(Task.Run(async () =>
            {
                try
                {
                    await clientSocket.SendAsync(
                        new ArraySegment<byte>(messageBytes),
                        WebSocketMessageType.Text,
                        true,
                        CancellationToken.None);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"發送失敗: {ex.Message}");
                    // 移除失敗的連線
                    _webSocket03Connections.TryRemove(kvp.Key, out _);
                }
            }));
        }
        else
        {
            // 移除已關閉的連線
            _webSocket03Connections.TryRemove(kvp.Key, out _);
        }
    }

    // 並行發送給所有客戶端
    await Task.WhenAll(tasks);
}
```

**廣播策略**：
- 並行發送訊息給所有客戶端（提高效率）
- 自動清理失敗或已關閉的連線
- 可選擇排除特定客戶端（例如發送者本身）

---

### 3. 前端 View 實作

```html
<div class="container mt-5">
    <h2>WebSocket 跨 Session 共用範例（聊天室）</h2>
    
    <div class="card">
        <div class="card-header">
            <h5>連線狀態: <span id="connectionStatus" class="badge bg-secondary">未連線</span></h5>
            <small>連線 ID: <span id="connectionId" class="text-muted">-</span></small>
            <span class="ms-3">線上人數: <span id="onlineCount" class="badge bg-info">0</span></span>
        </div>
        
        <div class="card-body">
            <!-- 連線控制按鈕 -->
            <button id="connectBtn" class="btn btn-primary">連線</button>
            <button id="disconnectBtn" class="btn btn-danger" disabled>斷線</button>
            
            <!-- 訊息類型選擇 -->
            <select id="messageType" class="form-select" disabled>
                <option value="text">文字</option>
                <option value="image">圖片</option>
                <option value="audio">聲音</option>
                <option value="video">影片</option>
                <option value="file">檔案</option>
            </select>
            
            <!-- 文字輸入 -->
            <div id="textInput">
                <input type="text" id="textContent" placeholder="輸入訊息..." disabled>
                <button id="sendBtn" disabled>傳送</button>
            </div>
            
            <!-- 檔案上傳 -->
            <div id="fileInput" style="display: none;">
                <input type="file" id="fileUpload" disabled>
                <button id="uploadBtn" disabled>上傳</button>
            </div>
            
            <!-- 訊息顯示區 -->
            <div id="messageLog" style="height: 400px; overflow-y: auto;">
                <p class="text-muted">等待連線...</p>
            </div>
        </div>
    </div>
</div>

<!-- 訊息範本 -->
<template id="messageContainerTemplate">
    <div class="mb-3 p-2 border rounded">
        <div class="d-flex justify-content-between">
            <strong data-sender></strong>
            <span class="text-muted small" data-time></span>
        </div>
        <div class="mb-2">
            <span class="badge" data-type-badge></span>
        </div>
        <div data-content></div>
        <div data-metadata-container></div>
    </div>
</template>
```

**UI 設計重點**：
- 顯示連線狀態和線上人數
- 動態切換輸入方式（文字 / 檔案）
- 使用 Template 元素優化訊息渲染
- 訊息日誌自動滾動

---

### 4. JavaScript 實作

#### 4.1 建立連線

```javascript
let ws = null;
let isConnected = false;
let myConnectionId = null;

function connect() {
    const wsUrl = getWebSocketUrl(); // 例如: ws://localhost:5000/Sample/WebSocket03

    ws = new WebSocket(wsUrl);

    ws.onopen = () => {
        isConnected = true;
        updateConnectionStatus('已連線', 'success');
        updateButtonStates();
    };

    ws.onmessage = async (event) => {
        const messageObj = JSON.parse(event.data);
        
        // 處理系統訊息（歡迎、加入、離開）
        if (messageObj.type === 'system') {
            if (messageObj.metadata?.connectionId) {
                myConnectionId = messageObj.metadata.connectionId;
                connectionId.textContent = myConnectionId;
            }
            
            if (messageObj.metadata?.totalConnections) {
                onlineCount.textContent = messageObj.metadata.totalConnections;
            }
            
            addLogMessage(messageObj.sender, messageObj, 'info');
        } else {
            // 判斷是自己還是別人的訊息
            const displayType = messageObj.sender === myConnectionId ? 'sent' : 'received';
            addLogMessage(messageObj.sender, messageObj, displayType);
        }
    };

    ws.onerror = (error) => {
        console.error('WebSocket 錯誤:', error);
    };

    ws.onclose = () => {
        isConnected = false;
        myConnectionId = null;
        updateConnectionStatus('未連線', 'secondary');
        connectionId.textContent = '-';
        onlineCount.textContent = '0';
        ws = null;
    };
}
```

#### 4.2 傳送文字訊息

```javascript
function sendTextMessage() {
    const content = textContent.value.trim();
    
    if (!content || !isConnected) return;

    const message = {
        type: 'text',
        content: content,
        sender: myConnectionId,
        timestamp: new Date().toISOString(),
        metadata: null
    };

    ws.send(JSON.stringify(message));
    textContent.value = '';
}
```

#### 4.3 傳送檔案訊息

```javascript
async function sendFileMessage() {
    const file = fileUpload.files[0];
    
    if (!file || !isConnected) return;

    try {
        // 將檔案轉換為 Base64
        const base64 = await fileToBase64(file);
        const type = messageType.value;

        const message = {
            type: type,
            content: base64,
            sender: myConnectionId,
            timestamp: new Date().toISOString(),
            metadata: {
                filename: file.name,
                size: file.size,
                mimeType: file.type
            }
        };

        // 如果是音訊或影片，獲取時長
        if (type === 'audio' || type === 'video') {
            const duration = await getMediaDuration(file, type);
            if (duration) {
                message.metadata.duration = duration;
            }
        }

        ws.send(JSON.stringify(message));
        fileUpload.value = '';
    } catch (error) {
        console.error('傳送檔案失敗:', error);
    }
}

// 檔案轉 Base64
function fileToBase64(file) {
    return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = () => resolve(reader.result);
        reader.onerror = reject;
        reader.readAsDataURL(file);
    });
}

// 獲取媒體時長
function getMediaDuration(file, type) {
    return new Promise((resolve) => {
        const url = URL.createObjectURL(file);
        const element = type === 'audio' ? new Audio() : document.createElement('video');

        element.addEventListener('loadedmetadata', () => {
            resolve(element.duration);
            URL.revokeObjectURL(url);
        });

        element.addEventListener('error', () => {
            resolve(null);
            URL.revokeObjectURL(url);
        });

        element.src = url;
    });
}
```

#### 4.4 訊息顯示

```javascript
function addLogMessage(sender, messageObj, displayType) {
    const timestamp = new Date().toLocaleTimeString('zh-TW');
    
    // 使用 Template 建立訊息元素
    const template = document.getElementById('messageContainerTemplate');
    const messageDiv = template.content.cloneNode(true).querySelector('div');

    // 設定樣式
    messageDiv.classList.add(...getMessageClass(displayType).split(' '));

    // 設定發送者
    const senderSpan = messageDiv.querySelector('[data-sender]');
    senderSpan.textContent = sender === myConnectionId ? '我' : sender;

    // 設定時間
    const timeSpan = messageDiv.querySelector('[data-time]');
    timeSpan.textContent = timestamp;

    // 設定類型標籤
    const typeBadge = messageDiv.querySelector('[data-type-badge]');
    typeBadge.className = `badge bg-${getTypeBadgeClass(messageObj.type)}`;
    typeBadge.textContent = getTypeDisplayName(messageObj.type);

    // 設定內容
    const contentDiv = messageDiv.querySelector('[data-content]');

    switch (messageObj.type) {
        case 'text':
        case 'system':
            contentDiv.textContent = messageObj.content;
            break;

        case 'image':
            const img = document.createElement('img');
            img.src = messageObj.content;
            img.className = 'img-fluid rounded';
            img.style.maxHeight = '200px';
            contentDiv.appendChild(img);
            break;

        case 'audio':
            const audio = document.createElement('audio');
            audio.src = messageObj.content;
            audio.controls = true;
            audio.className = 'w-100';
            contentDiv.appendChild(audio);
            break;

        case 'video':
            const video = document.createElement('video');
            video.src = messageObj.content;
            video.controls = true;
            video.className = 'w-100 rounded';
            video.style.maxHeight = '300px';
            contentDiv.appendChild(video);
            break;

        case 'file':
            contentDiv.innerHTML = `
                <i class="bi bi-file-earmark"></i> 
                <strong>檔案:</strong> ${messageObj.metadata?.filename || '未知檔案'}
            `;
            break;
    }

    // 顯示 Metadata
    if (messageObj.metadata) {
        const metadataContainer = messageDiv.querySelector('[data-metadata-container]');
        // ... 顯示 metadata 詳細資訊
    }

    messageLog.appendChild(messageDiv);
    messageLog.scrollTop = messageLog.scrollHeight; // 自動滾動到底部
}
```

---

## 訊息格式

所有訊息都使用 JSON 格式，基本結構如下：

```json
{
    "type": "text|image|audio|video|file|system|error",
    "content": "訊息內容或 Base64 資料",
    "sender": "發送者連線 ID",
    "timestamp": "2026-01-02T10:30:00Z",
    "metadata": {
        "key": "value"
    }
}
```

### 各類型訊息範例

#### 文字訊息
```json
{
    "type": "text",
    "content": "Hello, World!",
    "sender": "Client_1_abc123",
    "timestamp": "2026-01-02T10:30:00Z",
    "metadata": null
}
```

#### 圖片訊息
```json
{
    "type": "image",
    "content": "data:image/png;base64,iVBORw0KGgoAAAANSU...",
    "sender": "Client_2_def456",
    "timestamp": "2026-01-02T10:31:00Z",
    "metadata": {
        "filename": "photo.png",
        "size": 102400,
        "mimeType": "image/png"
    }
}
```

#### 系統訊息
```json
{
    "type": "system",
    "content": "Client_1_abc123 加入了聊天室",
    "sender": "Server",
    "timestamp": "2026-01-02T10:30:00Z",
    "metadata": {
        "event": "user-joined",
        "connectionId": "Client_1_abc123",
        "totalConnections": 5
    }
}
```

---

## 核心機制

### 1. 連線管理

```
連線生命週期：

┌─────────────┐
│ 客戶端連線  │
└──────┬──────┘
       │
       ▼
┌─────────────────────────┐
│ 產生唯一連線 ID          │
│ Client_{counter}_{guid}  │
└──────┬──────────────────┘
       │
       ▼
┌─────────────────────────┐
│ 加入 ConcurrentDict      │
│ _connections.Add(id, ws) │
└──────┬──────────────────┘
       │
       ▼
┌─────────────────────────┐
│ 發送歡迎訊息            │
│ 包含連線 ID 和線上人數   │
└──────┬──────────────────┘
       │
       ▼
┌─────────────────────────┐
│ 廣播「用戶加入」通知     │
│ 給其他所有用戶          │
└──────┬──────────────────┘
       │
       ▼
┌─────────────────────────┐
│ 進入訊息接收迴圈        │
│ while (ws.State == Open) │
└──────┬──────────────────┘
       │
       ▼
┌─────────────────────────┐
│ 連線關閉 / 錯誤         │
└──────┬──────────────────┘
       │
       ▼
┌─────────────────────────┐
│ 從字典中移除連線        │
│ _connections.Remove(id)  │
└──────┬──────────────────┘
       │
       ▼
┌─────────────────────────┐
│ 廣播「用戶離開」通知     │
└─────────────────────────┘
```

### 2. 廣播流程

```
訊息廣播流程：

客戶端 A 發送訊息
       │
       ▼
伺服器接收訊息
       │
       ▼
解析 JSON 並設定發送者 ID
       │
       ▼
序列化為 JSON 字串
       │
       ▼
遍歷所有活動連線
       │
       ├──► 客戶端 A （發送者）
       ├──► 客戶端 B
       ├──► 客戶端 C
       └──► 客戶端 D
            │
            ▼
       並行發送訊息
       （Task.WhenAll）
            │
            ▼
       處理發送失敗
       （移除失效連線）
```

### 3. 錯誤處理

- **連線失敗**：自動清理並通知其他用戶
- **發送失敗**：從連線字典中移除該連線
- **解析錯誤**：回傳錯誤訊息給發送者
- **檔案過大**：使用 64KB 緩衝區分段接收

---

## 使用方式

### 基本使用流程

1. **開啟聊天室頁面**
   - 導航到 `/Sample/WebSocket03`

2. **建立連線**
   - 點擊「連線」按鈕
   - 系統自動分配連線 ID
   - 顯示歡迎訊息和線上人數

3. **傳送文字訊息**
   - 確保訊息類型選擇「文字」
   - 在輸入框中輸入訊息
   - 點擊「傳送」或按 Enter 鍵

4. **傳送檔案**
   - 選擇訊息類型（圖片/音訊/影片/檔案）
   - 點擊「選擇檔案」上傳檔案
   - 點擊「上傳」按鈕

5. **查看訊息**
   - 自己的訊息顯示在右側（藍色邊框）
   - 他人的訊息顯示在左側（綠色邊框）
   - 系統訊息顯示為灰色

6. **斷開連線**
   - 點擊「斷線」按鈕
   - 系統會通知其他用戶

### 多視窗測試

為了測試聊天室功能，可以：

1. 開啟多個瀏覽器視窗或分頁
2. 每個視窗都連線到聊天室
3. 在任一視窗發送訊息
4. 觀察所有視窗都會即時收到訊息

---

## 技術要點

### 1. 執行緒安全

```csharp
// 使用 ConcurrentDictionary 確保執行緒安全
private static readonly ConcurrentDictionary<string, WebSocket> _webSocket03Connections = new();

// 使用 Interlocked 確保計數器原子性
var connectionId = $"Client_{Interlocked.Increment(ref _connectionIdCounter)}_{Guid.NewGuid():N}";
```

**為什麼需要執行緒安全？**
- WebSocket 連線在不同的執行緒中處理
- 多個客戶端可能同時連線或斷線
- 避免競態條件（Race Condition）

### 2. 記憶體管理

```csharp
// 使用 using 確保 MemoryStream 被正確釋放
using var memoryStream = new MemoryStream();

// WebSocket 也使用 using 確保連線被正確關閉
using var webSocket = await HttpContext.WebSockets.AcceptWebSocketAsync();
```

### 3. 大型訊息處理

```csharp
// 64KB 緩衝區
var buffer = new byte[1024 * 64];

// 循環接收直到訊息完整
do
{
    result = await webSocket.ReceiveAsync(
        new ArraySegment<byte>(buffer),
        CancellationToken.None);
    
    memoryStream.Write(buffer, 0, result.Count);
}
while (!result.EndOfMessage);
```

**支援的最大檔案大小**：
- 理論上無限制（受限於記憶體）
- Base64 編碼會增加約 33% 大小
- 建議限制在 10MB 以下以確保效能

### 4. JSON 序列化設定

```csharp
var options = new JsonSerializerOptions
{
    PropertyNameCaseInsensitive = true,  // 忽略大小寫
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase  // 使用 camelCase
};
```

### 5. 並行發送優化

```csharp
var tasks = new List<Task>();

foreach (var kvp in _webSocket03Connections)
{
    tasks.Add(Task.Run(async () => {
        await clientSocket.SendAsync(...);
    }));
}

// 等待所有發送完成
await Task.WhenAll(tasks);
```

**優點**：
- 提高廣播效率
- 減少總體延遲
- 避免單一客戶端阻塞

---

## 完整程式碼

### MessageObject 類別

```csharp
private class MessageObject
{
    public string? Type { get; set; }
    public string? Content { get; set; }
    public string? Sender { get; set; }
    public DateTime Timestamp { get; set; }
    public Dictionary<string, object>? Metadata { get; set; }
}
```

### 輔助方法

```csharp
// 解析 Base64 資料
private (string MimeType, long Size) ParseBase64Data(string? base64Data)
{
    if (string.IsNullOrEmpty(base64Data))
        return ("application/octet-stream", 0);

    try
    {
        if (base64Data.StartsWith("data:"))
        {
            var parts = base64Data.Split(',');
            if (parts.Length == 2)
            {
                var header = parts[0];
                var mimeType = header.Substring(5).Replace(";base64", "");
                
                var base64String = parts[1];
                var actualSize = (long)(base64String.Length * 0.75);
                
                if (base64String.EndsWith("=="))
                    actualSize -= 2;
                else if (base64String.EndsWith("="))
                    actualSize -= 1;
                
                return (mimeType, actualSize);
            }
        }
        
        var bytes = Convert.FromBase64String(base64Data);
        return ("application/octet-stream", bytes.Length);
    }
    catch
    {
        return ("application/octet-stream", 0);
    }
}

// 格式化檔案大小
private string FormatFileSize(long bytes)
{
    if (bytes < 1024)
        return $"{bytes} B";
    else if (bytes < 1024 * 1024)
        return $"{bytes / 1024.0:F2} KB";
    else if (bytes < 1024 * 1024 * 1024)
        return $"{bytes / (1024.0 * 1024.0):F2} MB";
    else
        return $"{bytes / (1024.0 * 1024.0 * 1024.0):F2} GB";
}
```

---

## 常見問題

### Q1: 為什麼要使用 static 欄位？

A: 因為每個 WebSocket 連線都會建立一個新的 Service 實例，使用 static 欄位可以讓所有實例共用同一個連線字典，實現跨 Session 通訊。

### Q2: 如何處理連線斷線？

A: 在 `finally` 區塊中處理：
```csharp
finally
{
    _webSocket03Connections.TryRemove(connectionId, out _);
    await BroadcastUserLeft(connectionId);
}
```

### Q3: 為什麼使用 Base64 傳輸檔案？

A: WebSocket 的 Text 模式只能傳輸文字，Base64 可以將二進位資料編碼為文字格式。雖然會增加 33% 的大小，但可以與 JSON 訊息格式整合。

### Q4: 如何限制檔案大小？

A: 可以在前端和後端都加上檢查：

**前端**：
```javascript
if (file.size > 10 * 1024 * 1024) { // 10MB
    alert('檔案過大，請選擇小於 10MB 的檔案');
    return;
}
```

**後端**：
```csharp
// 在 Program.cs 中設定
builder.WebHost.ConfigureKestrel(options =>
{
    options.Limits.MaxRequestBodySize = 10 * 1024 * 1024; // 10MB
});
```

### Q5: 如何實作私訊功能？

A: 修改廣播方法，只發送給特定用戶：

```csharp
private async Task SendPrivateMessageAsync(string targetConnectionId, MessageObject message)
{
    if (_webSocket03Connections.TryGetValue(targetConnectionId, out var targetSocket))
    {
        if (targetSocket.State == WebSocketState.Open)
        {
            var messageJson = JsonSerializer.Serialize(message);
            var messageBytes = Encoding.UTF8.GetBytes(messageJson);
            
            await targetSocket.SendAsync(
                new ArraySegment<byte>(messageBytes),
                WebSocketMessageType.Text,
                true,
                CancellationToken.None);
        }
    }
}
```

---

## 延伸應用

### 1. 群組聊天室
- 建立多個 `ConcurrentDictionary` 管理不同群組
- 使用者可以加入多個群組
- 訊息只廣播給同群組的用戶

### 2. 線上白板
- 傳送繪圖座標和顏色資訊
- 即時同步所有用戶的繪圖操作

### 3. 協作編輯
- 傳送文字變更的差異（diff）
- 使用 Operational Transformation 或 CRDT 處理衝突

### 4. 即時遊戲
- 傳送玩家位置和動作
- 同步遊戲狀態

### 5. 股票報價系統
- 即時推送價格更新給所有連線的客戶端

---

## 效能優化建議

### 1. 連線數限制
```csharp
private const int MaxConnections = 1000;

if (_webSocket03Connections.Count >= MaxConnections)
{
    await webSocket.CloseAsync(
        WebSocketCloseStatus.PolicyViolation,
        "伺服器已達最大連線數",
        CancellationToken.None);
    return;
}
```

### 2. 訊息佇列
對於高流量場景，使用訊息佇列（如 Redis Pub/Sub）：
```csharp
// 發送者將訊息放入 Redis
await redis.PublishAsync("chatroom", messageJson);

// 所有伺服器訂閱 Redis
await redis.SubscribeAsync("chatroom", (channel, message) =>
{
    BroadcastToLocalConnections(message);
});
```

### 3. 壓縮
啟用 WebSocket 壓縮：
```csharp
var webSocket = await HttpContext.WebSockets.AcceptWebSocketAsync(
    new WebSocketAcceptContext
    {
        DangerousEnableCompression = true
    });
```

### 4. 心跳檢測
定期發送 Ping/Pong 確認連線狀態：
```csharp
var timer = new Timer(async _ =>
{
    foreach (var kvp in _webSocket03Connections)
    {
        try
        {
            if (kvp.Value.State == WebSocketState.Open)
            {
                await kvp.Value.SendAsync(
                    new ArraySegment<byte>(Encoding.UTF8.GetBytes("ping")),
                    WebSocketMessageType.Text,
                    true,
                    CancellationToken.None);
            }
        }
        catch
        {
            _webSocket03Connections.TryRemove(kvp.Key, out _);
        }
    }
}, null, TimeSpan.FromSeconds(30), TimeSpan.FromSeconds(30));
```

---

## 安全性考量

### 1. 身份驗證
```csharp
// 在接受連線前驗證 Token
var token = HttpContext.Request.Query["token"];
if (!ValidateToken(token))
{
    HttpContext.Response.StatusCode = StatusCodes.Status401Unauthorized;
    return;
}
```

### 2. 輸入驗證
```csharp
// 驗證訊息內容
if (string.IsNullOrWhiteSpace(message.Content) || 
    message.Content.Length > 10000)
{
    // 拒絕過長或空白的訊息
    return;
}
```

### 3. 速率限制
```csharp
private static readonly ConcurrentDictionary<string, DateTime> _lastMessageTime = new();

// 檢查是否發送過快（例如 1 秒內只能發送 1 則）
if (_lastMessageTime.TryGetValue(connectionId, out var lastTime))
{
    if ((DateTime.Now - lastTime).TotalSeconds < 1)
    {
        // 拒絕發送
        return;
    }
}
_lastMessageTime[connectionId] = DateTime.Now;
```

### 4. XSS 防護
```javascript
// 在前端顯示文字時使用 textContent 而非 innerHTML
contentDiv.textContent = messageObj.content;

// 而不是
// contentDiv.innerHTML = messageObj.content; // 危險！
```

---

## 總結

WebSocket03 範例展示了完整的聊天室實作，包含：

✅ **跨 Session 通訊**：使用 static ConcurrentDictionary 管理所有連線  
✅ **訊息廣播**：並行發送訊息給所有客戶端  
✅ **多類型訊息**：支援文字、圖片、音訊、影片、檔案  
✅ **連線管理**：自動分配 ID、追蹤線上人數、清理斷線  
✅ **錯誤處理**：完善的異常處理和連線清理  
✅ **效能優化**：使用 Task.WhenAll 並行發送、64KB 緩衝區  

這個範例提供了構建即時通訊應用的完整基礎，可以根據實際需求進行擴展和優化。

---

## 參考資源

- [ASP.NET Core WebSocket 官方文件](https://learn.microsoft.com/zh-tw/aspnet/core/fundamentals/websockets)
- [WebSocket API (MDN)](https://developer.mozilla.org/zh-TW/docs/Web/API/WebSocket)
- [System.Collections.Concurrent](https://learn.microsoft.com/zh-tw/dotnet/api/system.collections.concurrent)
- [JSON 序列化 (System.Text.Json)](https://learn.microsoft.com/zh-tw/dotnet/standard/serialization/system-text-json-overview)

---

**文件版本**: 1.0  
**最後更新**: 2026-01-02  
**作者**: WebSocket Demo Project  
**分類**: ASP.NET Core > WebSocket
