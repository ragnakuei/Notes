# Tutorial

[Migrations](https://docs.microsoft.com/zh-tw/ef/core/managing-schemas/migrations/)

在 dotnet cli 加上 dotnet-ef cli

> dotnet tool install --global dotnet-ef

安裝套件

> dotnet add package Microsoft.EntityFrameworkCore

> dotnet add package Microsoft.EntityFrameworkCore.Design

> dotnet add package Microsoft.EntityFrameworkCore.SqlServer

> dotnet add package Microsoft.Extensions.Configuration

> dotnet add package Microsoft.Extensions.Configuration.FileExtensions

> dotnet add package Microsoft.Extensions.Configuration.Json

> dotnet add package Microsoft.Extensions.Configuration.EnvironmentVariables

建立 Migrations

> dotnet ef migrations add InitialCreate
> 必須在該專案目錄下執行

手動執行 Update 的方式

> dotnet ef database update
