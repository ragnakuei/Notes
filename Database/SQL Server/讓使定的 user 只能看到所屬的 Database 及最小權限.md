# 讓使定的 user 只能看到所屬的 Database 及最小權限

最小權限指的是 `db_datareader` 及 `db_datawriter`

> 詳細的設定方式，目前還沒抓到 !

## 可行的做法

-   建立新的使用者
-   套用[這個](./讓指定的%20user%20無法看到所有%20Database.md)至上述的使用者
-   建立新的 DataBase
-   套用[這個](./手動設定指定%20User%20為%20db%20owner.md)做法
-   把該 Database 的 db owner 改為 sa
-   在 Login 開啟 User 的 Login Property > User Mapping
    -   勾選該使用者有權限存取的 Database > 該 Database User 欄位為該 user 的 name
    -   Default schema 指定為 dbo
    -   Database role membership 勾選 `db_datareader` 及 `db_datawriter`
-   設定完畢

## TODO

可以在 ssms 設定好了之後，開啟 vs db 專案，然後 import 至 db 專案

-   要勾選包含 security / permission 的設定

就會有對應的 script 來了解怎麼調整 !
