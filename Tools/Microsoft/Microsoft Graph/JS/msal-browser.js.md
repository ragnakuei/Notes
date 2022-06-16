# [msal-browser.js](https://alcdn.msauth.net/browser/2.15.0/js/msal-browser.js)

## 增加回傳 RefreshToken 的方式

### msal-browser.js

ResponseHandler.generateAuthenticationResult 內 \_\_awaiter() 內的第四個引數 function 加上 refreshToken 變數

```js
// 加上 refreshToken 變數
var accessToken, responseScopes, expiresOn, extExpiresOn, familyId, popTokenGenerator, uid, tid, refreshToken,
```

\_\_generator() 第二個引數 function 內的 case 2 加上 refreshToken 變數的給定

```js
case 2:
    accessToken = cacheRecord.accessToken.secret;

    // 加上 refreshToken 變數的給定
    refreshToken = cacheRecord.refreshToken.secret;

    _d.label = 3;
```

### [authPopup.js](https://github.com/Azure-Samples/ms-identity-javascript-v2/blob/master/app/authPopup.js)

-   在登入時，就可以取得相關資料

    [function handleResponse(response)](https://github.com/Azure-Samples/ms-identity-javascript-v2/blob/master/app/authPopup.js#L32) 加上 傳入的 response 就會包含 accessToken 及 refreshToken

-   額外新增取得相關資料 function

    也可以新增 function 來取得 accessToken 及 refreshToken

    ```js
    function getAccessToken() {
        getTokenPopup(loginRequest)
            .then((response) => {
                console.log('getTokens', response);
            })
            .catch((error) => {
                console.error(error);
            });
    }
    ```
