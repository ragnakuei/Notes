# [Design-time DbContext Creation](https://docs.microsoft.com/zh-tw/ef/core/miscellaneous/cli/dbcontext-creation)

如果以 Console App 的方式來設計 DbContext 時，就會需要這樣的語法

用途

- 把 Code-First 放進版控中
- 以呼叫 exe 的方式來手動執行 Migration 的動作

注意事項
> 繼承 IDesignTimeDbContextFactory<T> 的 類別，一定要有無參數建構子

這樣才能被以下的指令正確判讀
> dotnet ef migrations add xxx

[實作](https://github.com/ragnakuei/DbMigrationsForEfCodeFirst)

## 待測

可以在別的專案放 DbContext，然後在 Console App 專案來實作 IDesignTimeDbContextFactory<T>

這樣同樣可以處理 Migrations
