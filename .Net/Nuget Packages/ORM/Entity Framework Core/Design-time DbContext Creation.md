# [Design-time DbContext Creation](https://docs.microsoft.com/zh-tw/ef/core/miscellaneous/cli/dbcontext-creation)

如果以 Console App 的方式來設計 DbContext 時，就會需要這樣的語法

用途

-   把 Code-First 放進版控中
-   以呼叫 exe 的方式來手動執行 Migration 的動作

## 關於發佈目的資料庫

第一種方式：以執行 console 來做 migrations

> 可套用指定的 appsettings.json 來指定發佈的目的地

第二種方式：以 dotnet ef cli 來做 migrations

> 預設只會讀取 appsettings.json

## 步驟

1. 所有關聯的 Project 不能是 .Net Standard
2. DbContext 所在 Project 不需要安裝 `Microsoft.EntityFrameworkCore.Design`
3. 建立繼承 IDesignTimeDbContextFactory\<TDbContext> 的 類別

    - 一定要有無參數建構子
    - 語法

    ```csharp
    public class TestCompany1ContextFactory : IDesignTimeDbContextFactory<TestDbContext>
    {
        private readonly IConfigurationRoot _configuration;

        public TestCompany1ContextFactory()
        {
            _configuration = DiHelpers.DiFactory<IConfigurationRoot>();
        }

        public TestDbContext CreateDbContext(string[] args)
        {
            var connectionString = _configuration.GetConnectionString("TestCompany1");

            var optionBuilder = new DbContextOptionsBuilder<TestDbContext>()
            .UseSqlServer(connectionString
                        , builder =>
                            {
                                builder.CommandTimeout(2400);
                                builder.EnableRetryOnFailure(2);
                                builder.MigrationsHistoryTable("_MigrationsHistory", "dbo");

                                // 這邊要指定 IDesignTimeDbContextFactory<T> 所在的 Assembly，而不是 DbContext 所在的 Assembly
                                builder.MigrationsAssembly("MigrationConsole");
                            });

            return new TestDbContext(optionBuilder.Options);
        }
    }
    ```

4. 建立 Migrations

    - Visual Studio

        要安裝以下套件

        ```xml
        <ItemGroup>
            <PackageReference Include="Microsoft.EntityFrameworkCore.Tools" Version="3.1.0" />
            <PackageReference Include="Microsoft.EntityFrameworkCore.Design" Version="3.1.0">
            <PackageReference Include="Microsoft.EntityFrameworkCore.Relational" Version="3.1.0" />
            <IncludeAssets>runtime; build; native; contentfiles; analyzers; buildtransitive</IncludeAssets>
            <PrivateAssets>all</PrivateAssets>
            </PackageReference>
        </ItemGroup>
        ```

        就可以使用 `Add-Migrations [MigrationName]`

    - dotnet core cli

        `dotnet ef migrations add [MigrationName]`

5. 執行程式進行 Migration

[實作](https://github.com/ragnakuei/DbMigrationsForEfCodeFirst)
