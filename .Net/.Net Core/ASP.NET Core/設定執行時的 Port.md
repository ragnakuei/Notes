# 設定執行時的 Port

於 `appsettings.json` 中加上

```json
  "Kestrel": {
    "EndPoints": {
      "Http": {
        "Url": "http://localhost:64958"
      }
    }
  }
```


[參考資料](https://blog.darkthread.net/blog/set-kestrel-port/)