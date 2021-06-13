# DynamicParameters

- [待 Study](https://dotblogs.com.tw/OldNick/2018/01/15/Dapper#INSERT%20statement)

## 未指定長度時

```csharp
string Connection = "Data Source=.\\mssql2017;Initial Catalog=Northwind;Integrated Security=True";

var param = new { CustomerID = "ALFKI" };

using (SqlConnection conn = new SqlConnection(Connection))
{
    conn.Query<dynamic>(@"SELECT * FROM Customers Where CustomerID = @customerId", param).Dump();
}
```

![Text](_images/01.png)

## 使用 DynamicParameters 並指定長度

```csharp
string Connection = "Data Source=.\\mssql2017;Initial Catalog=Northwind;Integrated Security=True";

var param = new DynamicParameters();
param.Add("CustomerID", "ALFKI", DbType.String, size: 20);

using (SqlConnection conn = new SqlConnection(Connection))
{
    conn.Query<dynamic>(@"SELECT * FROM Customers Where CustomerID = @customerId", param).Dump();
}
```

## 浮點數

```csharp
param.Add("FloatPrecision", dto.FloatPrecision, DbType.Decimal, precision: 18, scale: 10);
```

## DbType String 型別

如果不指定長度，就會以 4000 處理，就可能會造成效能 issue
| C# DbType | DB Type |
|-----------|---------|
|DbType.AnsiString|varchar|
|DbType.String|nvarchar|
|DbType.AnsiStringFixedLength|char|
|DbType.StringFixedLength|nchar|

## DbType 型別

目前可提供的型別對應如下：
| DB Type |
|---------|
|AnsiString|
|Binary|
|Byte|
|Boolean|
|Currency|
|Date|
|DateTime|
|Decimal|
|Double|
|Guid|
|Int16|
|Int32|
|Int64|
|Object|
|SByte|
|Single|
|String|
|Time|
|UInt16|
|UInt32|
|UInt64|
|VarNumeric|
|AnsiStringFixedLength|
|StringFixedLength|
|Xml|
|DateTime2|
|DateTimeOffset|

## 延伸閱讀

DbString 可對應至 DbType.AnsiString 及 DbType.String，但是無法對應至其他型別

| 參數名 | 說明 |
| ------ | ---- |
| IsAnsi | 是否為 Ansi 字串 (UTF-8 不是 Ansi 字串) |
| IsFixedLength | 是否為固定長度 |
| Length | 欄位長度 |

| IsAnsi      | IsFixedLength | DbType |
| ----------- | ------------- | ------ |
| true  | false | varchar |
| false | false | nvarchar |
| true  | true | char |
| false | true | nchar |


## 套用至 SQL 語法 IN

```csharp
var sql = @"
        SELECT p.Id,
            p.Name
        FROM [dbo].[Product] [p]
        WHERE [p].[Code] IN @Codes
        AND [p].[ParentId] = @ParentId
";

var param = new DynamicParameters();
param.AddDynamicParams(new { Codes = new[] { "CodeA", "CodeB" } });
param.Add("ParentId", 99, DbType.Int64);

return conn.Query<SelectListItem>(sql, param);
```