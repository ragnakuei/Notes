# 造成 Stored XSS 的高風險判斷

二個條件

-   該 .cshtml 使用 Html.Raw() 來呈現部份的資料
-   該頁面使用 @model 來傳入參數 - 這是 mvc 框架寫法，待確認判斷的細節 !

只要同時滿足上面二個條件，就會被 Checkmarx 判斷具有 Stored XSS 高風險
