## 

自訂轉換型別的處理


參考資料：
- [使用 Dapper 將 json string 轉換為 object](https://blog.yowko.com/dapper-json-string-to-object/)

- [透過自訂 Attribute 標示屬性讓 Dapper 進行 json 轉換](https://blog.yowko.com/dapper-customattribute-typehandler/)

- [Dapper小技巧：以資料表保存集合物件JSON](https://blog.darkthread.net/blog/dapper-typehandler/)


## 範例一：取值時轉換


```csharp
using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using Dapper;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;

namespace DapperSqlMapperTypeHandler
{
    class Program
    {
        static void Main(string[] args)
        {
            SqlMapper.AddTypeHandler(typeof(Customer), new JsonTypeHandler<Customer>());    
        
            string Connection = "Data Source=.\\mssql2017;Initial Catalog=Northwind;Integrated Security=True";
            
            using (SqlConnection conn = new SqlConnection(Connection))
            {
                var sql = @"select '{ ""Id"" : 1, ""Name"" : ""A"" }' as json";
                var result = conn.Query<Customer>(sql).FirstOrDefault();
                Console.WriteLine(result.Id);
                Console.WriteLine(result.Name);
            }
        }
    }
    
    public class JsonTypeHandler<T> : SqlMapper.TypeHandler<T>
    {
        // Read From Db
        public override T Parse(object value)
        {
            return JsonConvert.DeserializeObject<T>(value.ToString());
        }

        // Write To Db
        public override void SetValue(IDbDataParameter parameter, T value)
        {
            parameter.Value  = JsonConvert.SerializeObject(value);
            parameter.DbType = DbType.String;
        }
    }
    
    public class Customer
    {
        public int Id   { get; set; }
        public string Name  { get; set; }
    }
}
```

## 範例二：給值及取值的轉換

```csharp
class Program
{
    static void Main(string[] args)
    {
        Dapper.SqlMapper.ResetTypeHandlers();
        Dapper.SqlMapper.AddTypeHandler(typeof(Customer), new JsonTypeHandler<Customer>());

        string Connection = "Data Source=.\\mssql2017;Initial Catalog=Northwind;Integrated Security=True";

        var dto = new Dto
                       {
                           Customer = new Customer { Id = 1, Name = "A" }
                       };

        using (SqlConnection conn = new SqlConnection(Connection))
        {
            // @customer 對應到 dto 的 property name → customer
            // 此段將資料傳給 SQL Server 時，會先跑 SqlMapper.TypeHandler<T>.SetValue()
            var sql = @"select @customer as json";

            var result = conn.Query<Customer>(sql, dto).FirstOrDefault();

            // 此段讀取資料時，因為指定型態是 Customer，所以會跑 SqlMapper.TypeHandler<T>.Parse()

            Console.WriteLine(result.Id);
            Console.WriteLine(result.Name);
        }
    }
}

public class JsonTypeHandler<T> : SqlMapper.TypeHandler<T>
{
    // Read From Db
    public override T Parse(object value)
    {
        return JsonConvert.DeserializeObject<T>(value.ToString());
    }

    // Write To Db
    public override void SetValue(IDbDataParameter parameter, T value)
    {
        parameter.Value = (value == null)
                              ? (object)DBNull.Value
                              : JsonConvert.SerializeObject(value);
        parameter.DbType = DbType.String;
    }
}

public class Dto
{
    public Customer Customer { get; set; }
}

public class Customer
{
    public int    Id   { get; set; }
    public string Name { get; set; }
}
```

