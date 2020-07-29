# Connection String

[參考資料](https://www.connectionstrings.com/sql-server/)

## 範例

### 使用 Windows User / IIS User

關鍵：要有`Trusted_Connection=True;`

`Server=.\\mssql2017;Database=Northwind;Trusted_Connection=True;MultipleActiveResultSets=true`

1. Database 可設定指定使用者可登入
1. Database 可設定該使用者 User Mapping 指定的 Database role

### 使用指定 Db User

關鍵：不要有`Trusted_Connection=True;`，要有 `User Id=;Password=;`

`Server=.\\mssql2017;Database=Northwind;User Id=sa;Password=zzzz@ZZZZ;MultipleActiveResultSets=true`
