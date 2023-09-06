# 同 domain 不同 subdomain 下的 session 互相影響

## 情境

- b.domain 網站以 Session 來記錄登入狀態
- 步驟
  - 在 b.domain 登入
  - 網站 A.domain 中，以 \<a href="b.domain" target="_blank" /> 開啟 B.domain 的網頁
  - b.domain 就會被登出


### 較差的解法

- 把 sessionState 的 Session Cookie SameSite 屬性設為 `Lax`

    ```xml
    <system.web>
        <sessionState cookieSameSite="Lax" />
        <httpCookies httpOnlyCookies="true" requireSSL="true"></httpCookies>
    </system.web>
    ```

### 較佳的解法

- 不要用 Session Id 記錄登入狀態
- 不同 subdomain 的 WebSite 要使用不同的 Session Cookie Name

    ```xml
    <system.web>
        <sessionState cookieSameSite="Strict" cookieName="Site2" />
        <httpCookies httpOnlyCookies="true" requireSSL="true"></httpCookies>
    </system.web>
    ```