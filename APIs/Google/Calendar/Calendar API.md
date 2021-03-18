# Calendar API

calendar 上的每個 行程，叫做 `event`

## [reference](https://developers.google.com/calendar/v3/reference/)

每個 api 頁面右方，都有 `Try this API` 可以試

-   可以試出 Credentials 能用 OAuth 2 或 API Key

## 額度

-   每天 1000000 查詢
-   每使用者每 100 秒 500 個查詢

## 新增 event 範例

-   calendar id
    填自己的信箱

-   request body

    ```json
    {
        "end": {
            "date": "2020-08-11",
            "timeZone": "Asia/Taipei"
        },
        "start": {
            "date": "2020-08-10",
            "timeZone": "Asia/Taipei"
        },
        "summary": "TestSummaryA",
        "description": "TestDescripttionA"
    }
    ```

-   Credential 使用 `Google OAuth 2.0`
    將預設的二個 Scope 打勾
