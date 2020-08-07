# 設定 Collation 的方式

注意：

```
在建立 Table 之前，就要先設定好 Collation (特別是在 Ef COre 3 之前的版本，不要一次就 migration 全部的 dd)
否則字串欄位都有可能會有原本的 Collation 設定
```

## 在 Ef Core 3 之前

## 在 Ef Core 5 之後

提供 `UserCollation()` 來指定 Collation

DbContext.OnModelCreating()

```csharp
modelBuilder.UseCollation("Collation Name")
```
