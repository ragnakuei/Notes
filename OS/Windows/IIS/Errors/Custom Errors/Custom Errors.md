# Custom Errors

-   觸發後 Url 會產生 query string `aspxerrorpath=[原路徑]`
-   似疑會與 asp.net 整合一起處理 !

## Configuration

mode

-   On - 顯示自訂錯誤
-   Off - 不顯示自訂錯誤 - 就會顯示程式細部錯誤
-   RemoteOnly - 遠端使用者顯示自訂錯誤

redirectMode

-   ResponseRedirect
-   ResponseRewrite - 必須指定至實體檔案

## 參考資料

-   [[ASP.NET] 自訂網站 Exception 錯誤導向處理](https://dotblogs.com.tw/joysdw12/2013/05/20/104561)
