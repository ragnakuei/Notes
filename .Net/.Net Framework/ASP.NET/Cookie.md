# Cookie

- [相關測試方案](https://github.com/ragnakuei/CookieVsSessionTests)

## Cookie 設定 及 讀取 順序

- 從 Request 讀出 Cookie 的資料
- 寫入 COokie 則針對 Response !
- 要立即寫入 Cookie 至 Response 後，預設無法立即從 Request 取出 Cookie !
  - 流程上要先想棈楚 !
  - 因為 Response.Cookie 回應給 Client 後，要等下次 Request 才會放在 Request.Cookie 中 !


## Expires 
  - 在瀏覽器上看到的時間都是 UTC+0
  - 設定為 Session
    - 就算 Session Id 變更，該 Cookie 也不會過期 !
    - Session.Clear() - 該 Cookie 也不會過期 !
    - Session.Abandon() - 該 Cookie 也不會過期 !
    - Session.RemoveAll() - 該 Cookie 也不會過期 !
