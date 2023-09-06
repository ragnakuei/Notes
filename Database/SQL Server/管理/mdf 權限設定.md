# mdf 權限設定

用下面語法可以查出該 DB 可以給哪個 Account 存取

```sql
SELECT servicename, service_account
FROM sys.dm_server_services
```

也許不會有用
可以直接把 mdf 改為 Everyone 存取 > Attack mdf > 會自動調整權限
