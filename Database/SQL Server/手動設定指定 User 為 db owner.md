# 手動設定指定 User 為 db owner

設定 xxxDataBase 的 db owner 為 xxxUser

```sql
Use [xxxDataBase];
go
EXEC dbo.sp_changedbowner N'xxxUser';
go
```
