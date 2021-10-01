# 自訂 AuthenticationHandler 驗証 二個 JWT Schema

### 範例

-   流程

    1. 登入後，先取長時效的 refresh token
    2. 再拿 refresh token 換取 短時效的 access token
    3. 之後跟後端要資料，全部都要用 access token
    4. 短時效 access token 過期後，再用 refresh token 要過新的 access token
    5. refresh token 過期後，視為被登出

-   因為要驗証二種 JWT，所以用二個 JWT Schema 來分開驗証
-   [新增 Authentication 及 Schema 驗証](https://github.com/ragnakuei/ReserveRoom/blob/master/WebApiServer/Infra/JwtServiceHelper.cs)

-   Schema 驗証放在 [BaseAuthenticationHandler](https://github.com/ragnakuei/ReserveRoom/blob/master/WebApiServer/Infra/BaseAuthenticationHandler.cs) 中
    -   實作類別，主要是給定不同的 Properties
    -   [RefreshTokenAuthenticationHandler](https://github.com/ragnakuei/ReserveRoom/blob/master/WebApiServer/Jwt/RefreshTokenAuthenticationHandler.cs)
        -   Authorize 使用 AuthenticationSchemes.RefreshTokenSchema
    -   [AccessTokenAuthenticationHandler](https://github.com/ragnakuei/ReserveRoom/blob/master/WebApiServer/Jwt/AccessTokenAuthenticationHandler.cs)
        -   Authorize 使用 AuthenticationSchemes.AccessTokenSchema
-   [BaseJwtService](https://github.com/ragnakuei/ReserveRoom/blob/master/WebApiServer/Jwt/BaseJwtService.cs)
    -   產生 JWT 及 驗証
    -   [RefreshTokenJwtService](https://github.com/ragnakuei/ReserveRoom/blob/master/WebApiServer/Jwt/RefreshTokenJwtService.cs)
        -   給定產生 RefreshToken JWT 所需的資料
    -   [AccessTokenJwtService](https://github.com/ragnakuei/ReserveRoom/blob/master/WebApiServer/Jwt/AccessTokenJwtService.cs)
        -   給定產生 AccessToken JWT 所需的資料
