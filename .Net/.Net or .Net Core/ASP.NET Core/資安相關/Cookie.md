## Cookie

重點方向：

-   HttpOnly
-   Secure
-   SameSite = Strict
-   Expires / Expiration
    -   要保留時，不需要指定
    -   要讓瀏覽器刪掉時，才需要指定

注意：

> 不管是要設定還是要刪掉，上述的重點除 Expires / Expiration 需要動態指定外
> 其餘皆要設定 !

## Session Cookie

-   一定要設定 IdleTimeout
-   其餘同 Cookie 重點方向
