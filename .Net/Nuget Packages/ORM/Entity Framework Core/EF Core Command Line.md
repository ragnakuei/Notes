# Tools

[Entity Framework Core tools reference](https://docs.microsoft.com/zh-tw/ef/core/miscellaneous/cli/index)

[.NET CLI](https://docs.microsoft.com/zh-tw/ef/core/miscellaneous/cli/dotnet)
[Package Manager Console in Visual Studio](https://docs.microsoft.com/zh-tw/ef/core/miscellaneous/cli/powershell)

[搭配 dotnet core cli](https://docs.microsoft.com/zh-tw/ef/core/miscellaneous/cli/dotnet)

[update dotnet ef 的指令](https://docs.microsoft.com/zh-tw/ef/core/miscellaneous/cli/dotnet#updating-the-tools)


## 安裝 EF Core Cli

在 dotnet core 3.0 之後，EF Core Cli 不會預設與 .Net Core SDK 一起安裝

於 .Net Core Cli 操作

```
dotnet tool install --global dotnet-ef
```

於 Visual Studio Package Management Cosnole 操作

```
dotnet add package Microsoft.EntityFrameworkCore.Design
```

## 更新 EF Core Cli

```
dotnet tool update --global dotnet-ef
```

## 解除安裝 EF Core Cli

```
dotnet tool uninstall --global dotnet-ef
```