# 自訂 AuthenticationHandler 驗証 二個 JWT Scheme 搭配 CSRF Token

目前測試卡關情況：

在呼叫 api 取得 Refresh 時，需要回傳三個 token
- Csrf Token for Refresh Token
- Access Token
- Csrf Token for Access Token

所以等於總共需要呼叫 IAntiforgery 來產生不同的 Token，其中細節流程如下：

1. 取得 Csrf Token for Refresh Token 時，為第一次呼叫 IAntiforgery
1. 產生 Access Token ，並給定 HttpContext.User (目的是為了讓下一次 IAntiforgery 可以產出對應 Access Token 的 CSRF Token)
1. 取得 Csrf Token for Access Token 時，為第二次呼叫 IAntiforgery

但是 第二次呼叫 IAntiforgery 所產生的 Token 會與 第一次一致
疑似是 IAntiforgery 內部 Cache 造成的
所以導致以 Access Token + Csrf Token for Access Token 來取得資料時，會被判定為不同的 Claim User !

Cache 的猜測是：

只要從 IAntiforgery 取得 Token 時，就 cache 當下的 HttpContext.User Claims

即使之後更換了 HttpContext.User Claims，IAntiforgery 仍然會提供相同的 Token !

因此，以預設的 IAntiforgery 實作 DefaultAntiforgery 來看：

無法支援同時要產出二個以上的 JWT Scheme 的 CSRF Token !

