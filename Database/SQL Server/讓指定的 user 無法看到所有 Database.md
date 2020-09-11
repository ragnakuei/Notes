# 讓指定的 user 無法看到所有 Database

建立使用者

設定該使用者無法看到所有 DB

```sql
USE master;
DENY VIEW ANY DATABASE TO xxxUser;
GO
```
