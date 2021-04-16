# Dbcontext Scaffold

- [Package Manager Console 版](https://docs.microsoft.com/en-us/ef/core/cli/powershell#scaffold-dbcontext)

- [.Net Core Cli 版](https://docs.microsoft.com/en-us/ef/core/cli/dotnet#dotnet-ef-dbcontext-scaffold)

- 安裝套件：
  - Microsoft.EntityFrameworkCore.Design
  - Optional
    - Microsoft.EntityFrameworkCore.SqlServer

- 不會產生 Stored Procedure 的 Entity Model
  - 考慮用 windows form 
    - 呼叫 dbcontext scaffold 
    - 再取代原本 dbontext 檔案，把 Stored Procedure 的 Entity Model 資訊塞進去 !

## 範例

- 只產生 Model

```
dotnet ef dbcontext scaffold "Server=.\\MSSQL2017;Database=Northwind;Trusted_Connection=True;MultipleActiveResultSets=true" Microsoft.EntityFrameworkCore.SqlServer -o Models
```

- 指定 appsettings.json ConnectionStrings 的 Connection String Key

```
dotnet ef dbcontext scaffold name=DefaultConnection Microsoft.EntityFrameworkCore.SqlServer -o Models
```

- 要求建立 DbContext

```
dotnet ef dbcontext scaffold name=DefaultConnection Microsoft.EntityFrameworkCore.SqlServer -c NorthwindDbContext -o Models/Ef
```
