# [無法啟動 IIS Express]

## 錯誤情境：事件檢視器 Event ID 2269

可嘗試先重啟 w3svc、http，可能會列出有些服務未啟動，那些未啟動的服務可能就是 IIS Express 無法啟動的原因。

如果還是無法解決，可嘗試 [Event ID 2269 — IIS Worker Process Availability](https://social.technet.microsoft.com/wiki/contents/articles/21750.event-id-2269-iis-worker-process-availability.aspx) 的解決方案 !

[參考資料](https://dotblogs.com.tw/stanley14/2016/11/16/203045)
