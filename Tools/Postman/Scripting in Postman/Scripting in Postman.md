# [Scripting in Postman](https://learning.postman.com/docs/writing-scripts/intro-to-scripts/)




#### Pre-request Script

- 這個項目其實可以不用設定
  - **reqeust 的內容** 與 **Pre-request Script** 擇一維護就好
  - 因為 send request 送出時，會套用 Pre-request Script 的內容，無法分開維護 !

```js
pm.request.headers.add({key: 'Content-Type', value: 'application/json' });
pm.request.body = JSON.stringify([ 1, 2]);
```

