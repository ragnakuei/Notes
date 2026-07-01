# WithRetainFlag

語法

```cs
var message = new MqttApplicationMessageBuilder()
    .WithTopic($"device/{deviceId}/status")
    .WithPayload(json)
    .WithRetainFlag() // 設定保留標誌
    .Build();
    
await mqttClient.PublishAsync(message);
```

功用：

設定 MQTT 訊息的保留標誌 (Retain Flag)。當保留標誌被設置時，MQTT 代理會保存該訊息，並在有新的訂閱者訂閱該主題時立即將該訊息發送給他們。這對於需要讓新訂閱者獲取最新狀態資訊的應用場景非常有用。

