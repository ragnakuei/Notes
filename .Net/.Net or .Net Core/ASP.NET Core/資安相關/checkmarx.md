# checkmarx

## 高風險

- Action 以 Model 回傳至 View 時，如果沒有經過驗證，就會被視為高風險 !
  - 在使用輕前端 Vue 的情況下，可以直接改用 ViewBag 將資料傳遞至 View，然後直接 ToJson() 給 js 讀取。

- HttpGet 儘量不要用 query string & key 的資料型為 string，會被視為有 path traversal 的高風險。
