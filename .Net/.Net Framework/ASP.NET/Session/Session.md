# Session

參考資料
- [Exploring Session in ASP.NET](https://www.codeproject.com/Articles/32545/Exploring-Session-in-ASP-Net)

## Session Id 變動規則

- 只要未放入資料至 Session 中，那麼每次拿到的 Session Id 都會變 !
- 只要曾經放入資料至 Session 中，那麼每次拿到的 Session Id 就會固定 !

## 相關語法

### Session.Abandon()

- Asp.Net 才支援
- 此次 Request 結束後，才會清掉該 Session 所儲存的所有東西
  - 該次 Request 尚未結束前，仍取得到 Session 資料
- Session Id 變動規則與[這](#session-id-變動規則)一致

### Session.RemoveAll()

- Asp.Net 才支援
- 立即清掉該 Session 所儲存的所有東西
- Session Id 變動規則與[這](#session-id-變動規則)一致


### Session.Clear()

- 與 Asp.Net Core 實作不同 !
- 立即清掉該 Session 所儲存的所有東西
- Session Id 變動規則與[這](#session-id-變動規則)一致

## 設定逾時清空 Session 內容的方式

清空後，Session Id 變動規則與[這](#session-id-變動規則)一致

- Web.config 加上以下這段

    ```xml
    <system.web>
    <compilation debug="true" targetFramework="4.8"/>
    <httpRuntime targetFramework="4.8"/>

    <!-- 加上下面這行，單位：分鐘 -->
    <sessionState timeout="1" />
    </system.web>
    ```

## Asp.Net MVC

- 預設 Session Cookie Name：`ASP.NET_SessionId`
- 會將 Session Id 放入 Session Cookie Value 中
- [相關測試方案](https://github.com/ragnakuei/CookieVsSessionTests)

### 強制更新 Session Id 的方式

- 呼叫 Session.Clear()
- 將 Session Cookie 設定為 Expire
  - Expire 後，當下的 Cookie 會清掉，但是 Session 仍然還是會取到原本的 !
- 再重新 Rediret
  - 就可以重新取得新的 Session Id

```csharp
public ActionResult ExpireSessionCookie()
{
    Session.Clear();
    Response.Cookies.Add(new HttpCookie("ASP.NET_SessionId", null)
                            {
                                // Path      = null,
                                Secure    = true,
                                Shareable = false,
                                HttpOnly  = true,
                                // Domain    = null,
                                Expires  = DateTime.Now.AddDays(-1),
                                SameSite = SameSiteMode.Strict
                            });

    return RedirectToAction("Index");
}
```


