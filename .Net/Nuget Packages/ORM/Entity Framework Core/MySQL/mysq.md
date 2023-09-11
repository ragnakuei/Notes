# mysql

nuget package
- MySql.EntityFrameworkCore

[Scaffolding an Existing Database in EF Core](https://dev.mysql.com/doc/connector-net/en/connector-net-entityframework-core-scaffold-example.html#connector-net-entityframework-core-scaffold-cli)

> dotnet add package MySql.EntityFrameworkCore
> dotnet add package Microsoft.EntityFrameworkCore.Tools
> dotnet restore
> dotnet ef dbcontext scaffold "server=10.211.55.3;uid=root;pwd=000000;database=classicmodels" MySql.EntityFrameworkCore -o MySqlDb -f



dotnet ef dbcontext scaffold "server=10.211.55.3;uid=root;pwd=000000;database=classicmodels" MySql.EntityFrameworkCore -o MySqlDb -f
dotnet ef dbcontext scaffold "Name=ConnectionStrings:MySqlDb" MySql.EntityFrameworkCore -o MySqlDb -f
