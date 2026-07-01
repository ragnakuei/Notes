# MQTT Topic 完整說明

在 MQTT 協定中，**Topic（主題）** 是訊息路由的核心，決定了訊息的發送與接收路徑。它採用**階層式（Hierarchical）** 的結構，類似於檔案系統的路徑或 URL 路徑。良好的 Topic 設計不僅能讓系統擴展性更高，也能減少訂閱時的邏輯混亂，提升系統的可維護性。

> **核心概念**：Topic 就像一個郵政系統的地址，Publisher（發布者）將訊息投遞到指定的 Topic，而 Subscriber（訂閱者）只會收到他們訂閱的 Topic 訊息。

以下是 MQTT Topic 的完整說明與最佳實踐：

---

## 一、基礎語法規則

### 1. **區分大小寫**
`home/livingroom` 與 `Home/LivingRoom` 是兩個完全不同的主題。建議統一使用小寫字母以避免混誤。

### 2. **使用 UTF-8 編碼**
Topic 本質上是 UTF-8 編碼的字串，理論上支援各種語言字符。雖然可以使用中文（如：`家居/客廳/溫度`），但為了跨平台相容性與除錯方便，強烈建議使用 **ASCII 字符**。

### 3. **階層分隔符 `/`**
使用正斜線 `/` 來區分不同的層級，類似檔案系統路徑。

**範例**：
```
building_a/floor_1/room_101/temperature
devices/sensor_001/data/humidity  
factory/production_line_A/robot_01/status
```

### 4. **長度限制**
- 協定理論上允許長度高達 **65,535 位元組**
- 實務上建議保持在 **255 字符**以內，以減少封包標頭的大小負擔
- 過長的 Topic 會影響傳輸效率和記憶體使用

### 5. **字符限制**
- **禁用字符**：Topic 不能包含 `null` 字符（`\0`）
- **特殊字符**：避免使用控制字符（ASCII 0-31）
- **建議字符**：建議使用字母、數字、底線 `_`、連字號 `-`、點號 `.`

---

## 二、萬用字元（Wildcards）

**重要限制**：萬用字元_僅能用於「訂閱（Subscribe）」，不能用於「發布（Publish）」。_

### 1. **`+` 單層萬用字元（Single-level wildcard）**
- **功能**：匹配**單個**層級中的任何內容
- **位置**：可以放在 Topic 的任何層級位置
- **限制**：只能代替一個完整的層級

**範例**：
```
訂閱：myhome/+/temp
匹配：myhome/kitchen/temp     ✅
匹配：myhome/bedroom/temp     ✅
匹配：myhome/livingroom/temp  ✅
不匹配：myhome/kitchen/fridge/temp  ❌ (跨越了多個層級)
不匹配：myhome/temp           ❌ (缺少中間層級)
```

```
訂閱：sensors/+/data/+
匹配：sensors/temp/data/celsius    ✅
匹配：sensors/humidity/data/percent ✅
不匹配：sensors/temp/data          ❌
```

### 2. **`#` 多層萬用字元（Multi-level wildcard）**
- **功能**：匹配**任意數量**的層級（包括零層級）
- **位置**：**必須放在 Topic 的最末端**
- **特殊性**：只能單獨佔一個層級

**範例**：
```
訂閱：myhome/#
匹配：myhome/kitchen              ✅
匹配：myhome/kitchen/temp         ✅  
匹配：myhome/bedroom/light/switch ✅
匹配：myhome                      ✅ (零層級匹配)

訂閱：sensors/temperature/#
匹配：sensors/temperature/room1        ✅
匹配：sensors/temperature/room1/celsius ✅
匹配：sensors/temperature              ✅
```

### 3. **萬用字元組合使用**
```
訂閱：building/+/floor/+/#
匹配：building/A/floor/1/room/101      ✅
匹配：building/B/floor/2/temp          ✅
不匹配：building/A/temp                ❌
```

### 4. **常見錯誤範例**
```
❌ home#          (# 前面必須有 /)
❌ home/+temp     (+ 必須佔整個層級)
❌ home/#/temp    (# 必須在最末端)
✅ home/+         (正確)
✅ home/+/+       (正確)
✅ home/#         (正確)
```

---

## 三、最佳實踐建議（Do's & Don'ts）

### ❌ **避免的做法**

#### 1. **不要以 `/` 開頭**
雖然 `/home/sensor` 在技術上是合法的，但會在最前面產生一個「空層級」，這通常沒有意義且容易造成混亂。

```
❌ 錯誤：/home/sensor
❌ 錯誤：/devices/sensor_001
✅ 正確：home/sensor  
✅ 正確：devices/sensor_001
```

#### 2. **不要使用空白字元**
Topic 中應避免包含空格。如果需要分隔單字，請使用底線 `_` 或連字號 `-`。

```
❌ 錯誤：living room/light status
❌ 錯誤：sensor data/temperature
✅ 推薦：living_room/light_status
✅ 推薦：sensor-data/temperature
```

#### 3. **不要過度使用深層巢狀**
避免建立過於複雜的階層結構，一般建議控制在 **5-7 層**以內。

```
❌ 過於複雜：company/building/floor/room/area/device/sensor/type/unit/value
✅ 簡化後：company/building_floor/room/device/sensor_value
```

#### 4. **不要包含敏感資訊**
Topic 在 MQTT 中是明文傳輸的，不要在 Topic 中包含密碼、API Key 等敏感資料。

```
❌ 危險：devices/api_key_abc123/data
✅ 安全：devices/device_001/data
```

### ✅ **推薦的做法**

#### 1. **包含唯一標識碼**
在設計針對特定設備的 Topic 時，將設備唯一 ID 置入 Topic 是非常重要的。

```
✅ devices/sensor_9921/status
✅ users/user_12345/preferences  
✅ vehicles/car_VIN_123456789/telemetry
```

#### 2. **採用「從大到小」的階層邏輯**
像檔案夾分類一樣，從最廣泛的分類到最具體的屬性。

**建議模式**：`[組織]/[區域]/[系統]/[設備]/[數據類型]`

```
✅ factory_taipei/line_A/plc_001/temperature
✅ smart_home/living_room/light_001/brightness
✅ fleet_management/truck_001/gps/coordinates
```

#### 3. **使用一致的命名慣例**
在整個系統中保持一致的命名風格。

```
✅ 統一使用底線：device_001, sensor_data, room_temp
✅ 統一使用連字號：device-001, sensor-data, room-temp  
❌ 混用風格：device_001, sensor-data, roomTemp
```

#### 4. **考慮未來擴展性**
設計時要考慮系統未來的擴展需求。

```
✅ 可擴展：devices/{device_type}/{device_id}/{data_type}
   實例：devices/temperature_sensor/ts_001/celsius
   實例：devices/humidity_sensor/hs_002/percentage
```

#### 5. **使用語意化的名稱**
Topic 名稱應該具有描述性，讓人一眼就能理解其用途。

```
✅ 語意清晰：
   - sensors/outdoor/temperature
   - commands/motor/start
   - status/connection/online
   
❌ 語意不明：
   - data/001/val
   - cmd/m/s
   - st/c/on
```

### 3. ✅ 包含唯一標識碼（Client ID / Device ID）

在設計針對特定設備的指令或狀態主題時，將設備唯一 ID 置入 Topic 是非常重要的，這樣才能確保訊息傳送到正確的對象。

-   範例：`devices/sensor_9921/status`

### 4. ✅ 採用「從大到小」的階層邏輯

像檔案夾分類一樣，從最廣泛的分類到最具體的屬性。

-   **建議模式**：`[領域]/[位置]/[設備類別]/[設備ID]/[屬性]`
-   **實例**：`factory_a/line_1/motor/m001/vibration`

---

## 四、常見的設計模式與應用場景

### 1. **IoT 設備通訊模式**

| 模式                  | Topic 範例                     | 說明                                  | 使用時機 |
| --------------------- | ------------------------------ | ------------------------------------- | -------- |
| **Telemetry (遙測)**  | `devices/ID123/telemetry/temp` | 設備定期回傳的感測器數據              | 即時監控、數據收集 |
| **Status (狀態)**     | `devices/ID123/status`         | 設備的連線狀態（Online/Offline/Error）| 設備管理、故障檢測 |
| **Command (指令)**    | `devices/ID123/cmd/reboot`     | 後端下發給設備的控制指令              | 遠端控制、設備管理 |
| **Attributes (屬性)** | `devices/ID123/attributes`     | 設備的韌體版本、序號等靜態資訊        | 設備資訊管理 |
| **Events (事件)**     | `devices/ID123/events/alarm`   | 設備產生的重要事件通知                | 異常通知、日誌記錄 |

### 2. **實際應用範例**

#### **智慧家居系統**
```
home/living_room/light_001/state          # 燈具開關狀態
home/living_room/light_001/brightness     # 亮度值
home/living_room/thermostat/temperature   # 室溫
home/living_room/thermostat/set_point     # 設定溫度
home/security/door_sensor_001/status      # 門感應器狀態
home/security/motion_detector_001/alert   # 動作偵測警報
```

#### **工業物聯網 (IIoT)**
```
factory_001/production_line_A/motor_001/rpm        # 馬達轉速
factory_001/production_line_A/motor_001/vibration  # 振動數值
factory_001/production_line_A/sensor_temp_001/celsius # 溫度感測
factory_001/production_line_A/plc_001/status       # PLC 狀態
factory_001/maintenance/scheduler/next_service     # 維護排程
```

#### **車隊管理系統**
```
fleet/vehicle_001/gps/coordinates    # GPS 座標
fleet/vehicle_001/engine/temperature # 引擎溫度
fleet/vehicle_001/fuel/level         # 油量
fleet/vehicle_001/driver/id          # 駕駛員識別
fleet/alerts/vehicle_001/maintenance # 維修提醒
```

### 3. **雙向通訊模式**

#### **Request-Response 模式**
```
# 請求
request/device_001/get_status
# 回應  
response/device_001/status

# 或使用請求 ID 來配對
request/12345/device_001/get_config
response/12345/device_001/config
```

#### **Command-Acknowledgment 模式**
```
# 下達命令
command/device_001/reboot
# 確認收到
ack/device_001/reboot/received
# 執行結果
ack/device_001/reboot/completed
```

---

## 五、特殊 Topic 與保留字

### 1. **`$SYS` 系統 Topic**
以 `$` 開頭的主題通常是 **MQTT Broker（伺服器）內部預留**使用的系統資訊 Topic。

**常見的 $SYS Topic**：
```
$SYS/broker/version                    # Broker 版本資訊
$SYS/broker/clients/connected          # 目前連接的客戶端數量  
$SYS/broker/clients/maximum            # 同時連線的最大客戶端數
$SYS/broker/messages/received          # Broker 收到的訊息總數
$SYS/broker/messages/sent              # Broker 發送的訊息總數
$SYS/broker/bytes/received             # 收到的位元組總數
$SYS/broker/bytes/sent                 # 發送的位元組總數
$SYS/broker/subscriptions/count        # 目前訂閱總數
$SYS/broker/retained messages/count    # 保留訊息數量
```

**重要提醒**：
- 一般使用者**不應該**發布任何以 `$` 開頭的訊息
- `$SYS` Topic 的具體內容依 Broker 實作而異
- 這些 Topic 通常用於監控和診斷

### 2. **Last Will and Testament (LWT)**
當客戶端異常斷線時，Broker 會自動發布的訊息：
```
devices/sensor_001/status/lwt    # Last Will Topic
# 訊息內容：{"status": "offline", "timestamp": "2024-01-14T10:30:00Z"}
```

### 3. **Retained Messages**
使用 Retained Flag 的訊息會被 Broker 保存，新訂閱者會立即收到最後一次的訊息：
```
devices/sensor_001/config        # 設備設定（適合使用 Retained）
sensors/room_001/last_reading    # 最後讀數（適合使用 Retained）
```

---

## 六、Topic 設計的進階技巧

### 1. **命名空間 (Namespace) 策略**
使用命名空間來避免 Topic 衝突，特別是在多租戶系統中：

```
# 按組織劃分
company_a/devices/sensor_001/data
company_b/devices/sensor_001/data

# 按環境劃分  
prod/application/service_001/metrics
test/application/service_001/metrics
dev/application/service_001/metrics

# 按版本劃分
v1/api/users/notifications
v2/api/users/notifications
```

### 2. **地理位置階層**
```
# 國家/城市/建築物/樓層/房間
taiwan/taipei/building_101/floor_5/room_501/temperature
usa/new_york/building_a/floor_1/lobby/co2_level
```

### 3. **時間序列資料**
```
# 按時間粒度分類
metrics/hourly/cpu_usage
metrics/daily/network_traffic  
metrics/monthly/storage_usage

# 包含時間戳記的歷史資料
archive/2024/01/14/sensor_001/temperature
```

### 4. **資料類型分類**
```
raw_data/sensor_001/temperature      # 原始資料
processed/sensor_001/temperature     # 處理後資料  
aggregated/sensor_001/temperature    # 聚合資料
alerts/sensor_001/temperature        # 異常警報
```

### 5. **多協定整合**
在混合協定環境中，使用 Topic 來區分資料來源：
```
mqtt/devices/sensor_001/data         # 來自 MQTT 的資料
http/api/sensor_001/data            # 來自 HTTP API 的資料
modbus/plc_001/registers            # 來自 Modbus 的資料
```

---

## 七、效能與安全性考量

### 1. **Topic 數量管理**
- **避免 Topic 爆炸**：過多的 Topic 會影響 Broker 效能
- **合理使用萬用字元**：過度使用 `#` 可能造成不必要的訊息接收
- **定期清理**：移除不再使用的 Topic 訂閱

### 2. **安全性設計**
```
# 按權限層級設計
public/weather/taipei              # 公開資訊
internal/company/employee_data     # 內部資訊  
private/user_12345/personal_data   # 私人資訊
```

### 3. **負載分散**
```
# 按資料頻率分類
high_freq/sensor_001/data          # 高頻率資料（每秒）
medium_freq/sensor_001/status      # 中頻率資料（每分鐘）
low_freq/sensor_001/config         # 低頻率資料（每小時）
```

---

## 八、除錯與監控

### 1. **除錯用的 Topic**
```
debug/device_001/logs              # 設備除錯日誌
debug/device_001/network_status    # 網路狀態資訊
debug/system/memory_usage          # 系統資源使用情況
```

### 2. **監控指標**
```
metrics/broker/message_throughput   # 訊息吞吐量
metrics/broker/connection_count     # 連線數量
metrics/application/response_time   # 應用程式回應時間
```

### 3. **日誌與稽核**
```
audit/user_actions/login           # 使用者行為稽核
audit/device_commands/executed     # 設備指令執行記錄
logs/errors/application            # 應用程式錯誤日誌
```

---

## 九、實作建議與工具

### 1. **Topic 設計檢查清單**
在設計 Topic 時，檢查以下項目：

- [ ] 命名是否具有描述性和直觀性？
- [ ] 階層結構是否合理且可擴展？
- [ ] 是否避免了過深的巢狀結構？
- [ ] 是否包含必要的唯一標識符？
- [ ] 是否考慮了未來的擴展需求？
- [ ] 是否符合組織的命名規範？
- [ ] 是否避免了敏感資訊洩露？

### 2. **測試工具**
```bash
# 使用 MQTT 命令列工具測試
mosquitto_pub -h broker.example.com -t "test/device_001/data" -m "hello"
mosquitto_sub -h broker.example.com -t "test/+/data"
mosquitto_sub -h broker.example.com -t "test/#"
```

### 3. **文件化範例**
為您的 MQTT Topic 建立完整的文件：

```markdown
## Topic 規範文件

### 設備遙測資料
- **Topic**: `devices/{device_id}/telemetry/{sensor_type}`
- **方向**: 設備 → 伺服器
- **頻率**: 每 30 秒
- **範例**: `devices/temp_001/telemetry/celsius`
- **Payload**: `{"value": 25.6, "timestamp": "2024-01-14T10:30:00Z"}`

### 設備控制指令  
- **Topic**: `devices/{device_id}/commands/{command_type}`
- **方向**: 伺服器 → 設備
- **回應**: `devices/{device_id}/responses/{command_type}`
- **範例**: `devices/relay_001/commands/turn_on`
```

---

## 總結

設計優秀的 MQTT Topic 需要綜合考慮以下因素：

1. **可讀性**：Topic 應該直觀易懂，讓團隊成員能快速理解
2. **可維護性**：良好的階層結構便於後續的維護和擴展
3. **效能性**：合理的 Topic 設計能提升系統整體效能
4. **安全性**：考慮資料敏感度和存取權限控制
5. **擴展性**：為未來的系統成長預留設計空間

**核心原則**：「如果我以後增加 1000 台設備，目前的 Topic 結構還能清楚地區分它們嗎？」

如果您正在設計特定的系統（例如：智慧工廠、智慧家居、車隊管理），我可以幫您規劃一套完整的 Topic 架構設計。只需提供您的應用場景和需求，我就能為您量身打造最適合的 MQTT Topic 規範。
