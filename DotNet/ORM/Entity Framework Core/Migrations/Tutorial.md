# Tutorial

[Migrations](https://docs.microsoft.com/zh-tw/ef/core/managing-schemas/migrations/)

透過 dotnet cli 安裝 ef cli

> dotnet tool install --global dotnet-ef

安裝套件

> dotnet add package Microsoft.EntityFrameworkCore.Design

建立 Migrations

> dotnet ef migrations add InitialCreate
> 必須在該專案目錄下執行

手動執行 Update 的方式

> dotnet ef database update
 