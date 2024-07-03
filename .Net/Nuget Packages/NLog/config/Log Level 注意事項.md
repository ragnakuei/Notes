# Log Level 注意事項

.Net 內的 Log Level 為 全名

> Trace / Debug / Information / Warning / Error / Critical / None

但 NLog 內的 Log Level 有點不同

> Trace / Debug / Info / Warn / Error / Fatal / Off

如果設定檔內的 Log Level 寫錯，該 Target 檔案就不會有寫入的動作 !

而 Log Level 以 NLog 為主，不會看 appsettings.json 的 Logging.LogLevel
