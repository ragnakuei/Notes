# WebPush

[github](https://github.com/web-push-libs/web-push-csharp)

- 支援 .net / .net core / .net framework 4.5 ↑


## 範例

[範例一](https://github.com/ragnakuei/AspNetCorePushNotification)

關鍵
- 推播用的 keypair
  - [VAPID Key Generator](https://www.attheminute.com/vapid-key-generator/)
- 後端記錄 client browser 資訊
- push notification 時，將需要的資料以 json 格式放進 payload 中
- browser service worker 收到 push 時，從 event.data 取出 json 資料
  - 可將一些資料傳遞給 showNotification 的 options 中
  - 讓 service worker notificationclick event 可以從 event.notification.data 取出
  - 以達成自由給定 url 的方式

#### 沒有 message 欄位

如果要塞一些客制化的欄位，這個常用套件 [webpush](https://github.com/zaru/webpush#with-a-payload) 有一個 message 欄位

