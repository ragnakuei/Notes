# [Migrations](https://docs.microsoft.com/zh-tw/ef/core/managing-schemas/migrations/)

在 dotnet cli 加上 dotnet-ef cli (dotnet core v3.1 後)

> dotnet tool install --global dotnet-ef

安裝套件

> dotnet add package Microsoft.EntityFrameworkCore
> dotnet add package Microsoft.EntityFrameworkCore.SqlServer
> dotnet add package Microsoft.Extensions.Configuration
> dotnet add package Microsoft.Extensions.Configuration.FileExtensions
> dotnet add package Microsoft.Extensions.Configuration.Json
> dotnet add package Microsoft.Extensions.Configuration.EnvironmentVariables

Migrations 專案安裝套件

> dotnet add package Microsoft.EntityFrameworkCore.Design

操作 Migrations

- Visual Studio

  - 透過套件管理主控台操作
    - 必須切換至 Migration 專案
  - 必須設定 Migration 專案為起始專案

    | 動作      | 指令                          | 說明 |
    | --------- | ----------------------------- | ---- |
    | 新增      | Add-Migration [MigrationName] |      |
    | 移除      | Remove-Migration              |      |
    | 更新至 DB | Update-Database               |      |

- .net core cli

  - 透過 command line 操作
  - 必須在該專案目錄下執行

    | 動作      | 指令                                     | 說明 |
    | --------- | ---------------------------------------- | ---- |
    | 新增      | dotnet ef migrations add [MigrationName] |      |
    | 移除      | dotnet ef migrations remove              |      |
    | 更新至 DB | dotnet ef database update                |      |
