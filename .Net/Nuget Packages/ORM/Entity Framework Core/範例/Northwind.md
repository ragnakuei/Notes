# Northwind

### 環境

Console

.Net Framework 4.8

### 安裝套件

```powershell
Install-Package Microsoft.EntityFrameworkCore
Install-Package Microsoft.EntityFrameworkCore.SqlServer
Install-Package Microsoft.Extensions.Configuration
Install-Package Microsoft.Extensions.Configuration.Json
Install-Package Microsoft.Extensions.Options.ConfigurationExtensions
```

### C#

```csharp
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;

namespace EfCoreStoredProcedure
{
    class Program
    {
        static void Main(string[] args)
        {
            var context = DiFactory.GetService<NorthwindContext>();
            var customer = context.Customers.FirstOrDefault();
            Console.WriteLine(customer.CustomerID);
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
        public DbSet<Customer> Customers { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Customer>().ToTable("Customers");
        }
    }

    [Table("Customers")]
    public class Customer
    {
        [Key]
        [MaxLength(5)]
        public string CustomerID { get; set; }
        [MaxLength(40)]
        public string CompanyName { get; set; }
        [MaxLength(30)]
        public string ContactName { get; set; }
        [MaxLength(30)]
        public string ContactTitle { get; set; }
        [MaxLength(60)]
        public string Address { get; set; }
        [MaxLength(15)]
        public string City { get; set; }
        [MaxLength(15)]
        public string Region { get; set; }
        [MaxLength(10)]
        public string PostalCode { get; set; }
        [MaxLength(15)]
        public string Country { get; set; }
        [MaxLength(24)]
        public string Phone { get; set; }
        [MaxLength(24)]
        public string Fax { get; set; }
    }
}
```

### 新增 appsettings.json

要記得設定複製到編譯資料夾下

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=.\\mssql2017;Database=Northwind;Trusted_Connection=True;MultipleActiveResultSets=true"
  }
}
```