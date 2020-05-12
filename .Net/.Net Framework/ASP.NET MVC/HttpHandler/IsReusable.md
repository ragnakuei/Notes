# IsReusable 

用來判斷多個 Request 是否要共用該 Handler

| 值    | 說明                       |
| ----- | -------------------------- |
| true  | 建議以無狀態來設計 Handler |
| false | 各 Reqeust 都是分開的      |

參考資料

- [小心使用IHttpHandler下的IsReusable属性](https://www.cnblogs.com/TomXu/archive/2011/12/17/2288579.html)
