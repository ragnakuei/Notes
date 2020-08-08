# 設定 Collation 的方式

注意：

```
所有 table 的 column，如果不指定 collation ，就會全部指定為 database 的 collationn
在建立 table 後，再修改 database 的 collation，就會導致 table columns 的 collation 與 database 的 collation 不一致

在建立 Table 之前，就要先設定好 Collation (特別是在 Ef Core 3 之前的版本，不要一次就 migration 全部的 dd)
否則字串欄位都有可能會有原本的 Collation 設定
```

## 在 Ef Core 3.x (含)之前

[如何在 EF Core 3.1 的 Code First 進行資料庫移轉時指定資料庫定序](https://blog.miniasp.com/post/2020/08/07/EF-Core-31-Code-First-DB-Migration-set-collation)

## 在 Ef Core 5.x (含)之後

提供 `UserCollation()` 來指定 Collation

DbContext.OnModelCreating()

```csharp
modelBuilder.UseCollation("Collation Name")
```
