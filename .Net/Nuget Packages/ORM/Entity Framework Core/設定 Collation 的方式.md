# 設定 Collation 的方式

## 在 Ef Core 3 之前

## 在 Ef Core 5 之後

提供 `UserCollation()` 來指定 Collation

DbContext.OnModelCreating()

```csharp
modelBuilder.UseCollation("Collation Name")
```
