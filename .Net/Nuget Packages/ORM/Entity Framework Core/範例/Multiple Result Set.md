# Multiple Result Set

---

預備知識

[Multiple Result Set](../Multiple%20Result%20Set.md)

### C#

```csharp
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Data.Common;

namespace EfCoreStoredProcedure
{
    class Program
    {
        static void Main(string[] args)
        {
            var context = DiFactory.GetService<NorthwindContext>();

            var querySql = @"
DROP TABLE IF EXISTS #tempValues

create table #tempValues
(
    [value] nvarchar(200)
)
INSERT INTO #tempValues(value)
SELECT @value

select *
from #tempValues

select *
from #tempValues
UNION ALL
select *
from #tempValues

DROP TABLE IF EXISTS #tempValues
";
            var value = "Test";

            var parameter = new SqlParameter(nameof(value), value);

            var command = context.Database.GetDbConnection().CreateCommand();
            command.CommandText = querySql;
            command.CommandType = CommandType.Text;
            command.Parameters.Clear();
            command.Parameters.Add(parameter);

            var result = new ValueDTO();
            result.Part1 = new List<QueryTempValue>();
            result.Part2 = new List<QueryTempValue>();

            // context.Database.OpenConnection();
            context.Database.GetDbConnection().Open();
            using (var reader = command.ExecuteReader())
            {
                result.Part1 = reader.Translate<QueryTempValue>();
                result.Part2 = reader.Translate<QueryTempValue>();
            }
            // context.Database.CloseConnection();
            context.Database.GetDbConnection().Close();
        }
    }

    public static class DiFactory
    {
        private static readonly ServiceProvider _provider;

        static DiFactory()
        {
            var _services = new ServiceCollection();

            var configuration = new ConfigurationBuilder()
                                .AddJsonFile("appsettings.json", optional: true)
                                .Build();
            _services.AddSingleton(_ => configuration);

            _services.AddDbContext<NorthwindContext>(
                options =>
                    options.UseSqlServer(configuration.GetConnectionString("DefaultConnection")));

            _provider = _services.BuildServiceProvider();
        }

        public static T GetService<T>()
        {
            return _provider.GetService<T>();
        }
    }

    public class NorthwindContext : DbContext
    {
        public NorthwindContext(DbContextOptions<NorthwindContext> options) : base(options) { }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
        }
    }

    public static class DataRecordExtensions
    {
        private static readonly ConcurrentDictionary<Type, object> _materializers = new ConcurrentDictionary<Type, object>();
        public static IList<T> Translate<T>(this DbDataReader reader) where T : new()
        {
            var materializer = (Func<IDataRecord, T>)_materializers.GetOrAdd(typeof(T), (Func<IDataRecord, T>)Materializer.Materialize<T>);
            // var materializer2 = new Func<IDataRecord, T>((IDataRecord dataRecord) => Materializer.Materialize<T>(dataRecord));
            return Translate(reader, materializer, out var hasNextResults);
        }

        private static IList<T> Translate<T>(this DbDataReader reader, Func<IDataRecord, T> objectMaterializer)
        {
            return Translate(reader, objectMaterializer, out var hasNextResults);
        }

        private static IList<T> Translate<T>(this DbDataReader reader, Func<IDataRecord, T> objectMaterializer, out bool hasNextResult)
        {
            var results = new List<T>();
            while (reader.Read())
            {
                var record = (IDataRecord)reader;
                var obj = objectMaterializer.Invoke(record);
                results.Add(obj);
            }
            hasNextResult = reader.NextResult();
            return results;
        }
    }

    public class Materializer
    {
        public static T Materialize<T>(IDataRecord record) where T : new()
        {
            var t = new T();
            foreach (var prop in typeof(T).GetProperties())
            {
                // 1). If entity reference, bypass it.
                if (prop.PropertyType.Namespace == typeof(T).Namespace)
                {
                    continue;
                }
                // 2). If collection, bypass it.
                if (prop.PropertyType != typeof(string) && typeof(IEnumerable<>).IsAssignableFrom(prop.PropertyType))
                {
                    continue;
                }
                // 3). If property is NotMapped, bypass it.
                if (Attribute.IsDefined(prop, typeof(NotMappedAttribute)))
                {
                    continue;
                }
                var dbValue = record[prop.Name];

                if (dbValue is DBNull)
                {
                    continue;
                }

                if (prop.PropertyType.IsConstructedGenericType &&
                    prop.PropertyType.GetGenericTypeDefinition() == typeof(Nullable<>))
                {
                    var baseType = prop.PropertyType.GetGenericArguments()[0];
                    var baseValue = Convert.ChangeType(dbValue, baseType);
                    var value = Activator.CreateInstance(prop.PropertyType, baseValue);
                    prop.SetValue(t, value);
                }
                else
                {
                    var value = Convert.ChangeType(dbValue, prop.PropertyType);
                    prop.SetValue(t, value);
                }
            }
            return t;
        }
    }

    public class ValueDTO
    {
        public IList<QueryTempValue> Part1 { get; internal set; }
        public IList<QueryTempValue> Part2 { get; internal set; }
    }

    public class QueryTempValue
    {
        public string Value { get; set; }
    }
}
```