# [httpErrors](https://docs.microsoft.com/en-us/iis/configuration/system.webServer/httpErrors/)

如果輸入的 URL 經過 Route 判斷仍找不到對應的頁面，就會執行到這個區塊

### 基本範例

```xml
<configuration>
  <system.webServer>
    <httpErrors errorMode="Custom" existingResponse="Replace">
      <remove statusCode="404" subStatusCode="-1" />
      <error statusCode="404" subStatusCode="-1" path="http://localhost:9142/404.html" responseMode="Redirect" />
    </httpErrors>
  </system.webServer>
</configuration>
```

### path 設定範例如下

```xml
<error statusCode="404" subStatusCode="-1" path="/Error/NotFound" responseMode="Redirect" />
```

```xml
<error statusCode="404" subStatusCode="-1" path="/404.html" responseMode="Redirect" />
```

```xml
<error statusCode="404" subStatusCode="-1" path="http://localhost:9142/404.html" responseMode="Redirect" />
```

### responseMode
|            |                                                                |
| ---------- | -------------------------------------------------------------- |
| Redirect   | 轉到指定的"絕對路徑"，URL 會跟著變                             |
| ExecuteURL | 轉到指定的"Host 相對路徑"，URL 不會跟著變(推薦)  path="/Error/ | NotFound" |
| File       | 指定 系統絕對路徑，未測                                        |

如果出現空白頁面

請檢查 絕對路徑、相對路徑 與 responseMode 是否設定正確