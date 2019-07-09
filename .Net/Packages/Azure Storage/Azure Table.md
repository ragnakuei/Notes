
# 安裝套件
> Install-Package WindowsAzure.Storage

# Normal Mode

# Batch Mode


```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Table;
using NUnit.Framework;

namespace Tube.Test
{
    [TestFixture]
    public class TestAzureTable
    {
        private static readonly string DataStorageKey = "";
        private static readonly string DataStorageName = "";
        private static readonly string _connectionString = $"DefaultEndpointsProtocol=https;AccountName={DataStorageName};AccountKey={DataStorageKey}";
        
        [Test]
        public void Insert()
        {
            var cloudStorageAccount = CloudStorageAccount.Parse(_connectionString);
            var tableReference      = cloudStorageAccount.CreateCloudTableClient().GetTableReference(typeof(OrderItemTest).Name);
            tableReference.CreateIfNotExists(requestOptions : null, operationContext : null);

            var count = 1000000;
            var tasks = new Task[count];
            
            for (int i = 9226 ; i < count ; i++)
            {
                var no = i.ToString("000000000000");
                tasks[i] = Task.Run(() => tableReference.InsertSingleAsync(new OrderItemTest
                                                                          {
                                                                              PartitionKey = $"00000000-0000-0000-0000-{no}",
                                                                              RowKey       = $"10000000-0000-0000-0000-{no}",
                                                                              Timestamp    = DateTimeOffset.UtcNow,
                                                                              ShopId       = $"20000000-0000-0000-0000-{no}",
                                                                              Quantity     = 1,
                                                                              ProductId    = $"30000000-0000-0000-0000-{no}",
                                                                              PriceId      = $"40000000-0000-0000-0000-{no}",
                                                                              Note         = $"Note{no}",
                                                                              OrderTitle   = $"OrderTitile{no}",
                                                                              Creater      = new Guid($"50000000-0000-0000-0000-{no}"),
                                                                              CreateOn     = DateTime.UtcNow,
                                                                              Updater      = new Guid($"60000000-0000-0000-0000-{no}"),
                                                                              UpdateOn     = DateTime.UtcNow,
                                                                          }));
            }

            Task.WaitAll(tasks.Where(t=>t!=null).ToArray());
        }
        
        [Test]
        public void Query1000()
        {
            var cloudStorageAccount = CloudStorageAccount.Parse(_connectionString);
            var tableReference      = cloudStorageAccount.CreateCloudTableClient().GetTableReference(typeof(OrderItemTest).Name);
            tableReference.CreateIfNotExists(requestOptions : null, operationContext : null);

            var startNo = 1;
            var endNo = 2000;
            var count = endNo - startNo + 1;
            var partitionKeys = new string[count];
            
            for (int i = 0 ; i < count ; i++)
            {
                var no = (startNo + i).ToString("000000000000");
                var partitionKey = $"00000000-0000-0000-0000-{no}";
                partitionKeys[i] = partitionKey;
            }
            
            var result = tableReference.Query<OrderItemTest>("PartitionKey", partitionKeys);

            Assert.AreEqual(endNo, result.Count);
        }
        
    }

    public static class AzureTableHelper
    {
        public static async Task InsertSingleAsync<T>(this CloudTable cloudTable, T tableInstance) where T : ITableEntity, new()
        {
            TableOperation insertOperation = TableOperation.Insert(tableInstance);
            await cloudTable.ExecuteAsync(insertOperation);
        }
        
        public static void InsertSingle<T>(this CloudTable cloudTable, T tableInstance) where T : ITableEntity, new()
        {
            TableOperation insertOperation = TableOperation.Insert(tableInstance);
            cloudTable.Execute(insertOperation);
        }
        
        public static void Insert<T>(this CloudTable cloudTable, IEnumerable<T> tableInstances) where T : ITableEntity, new()
        {
            foreach (T tableInstance in tableInstances)
            {
                TableOperation insertOperation = TableOperation.Insert(tableInstance);
                cloudTable.Execute(insertOperation);
            }
        }
        
        /// <summary>
        /// 要用相同的 Partition Key
        /// </summary>
        public static void BatchInsert<T>(this CloudTable cloudTable, IEnumerable<T> tableInstances) where T : ITableEntity, new()
        {
            TableBatchOperation batch = new TableBatchOperation();

            foreach (T tableInstance in tableInstances)
            {
                batch.Insert(tableInstance);
            }
                
            cloudTable.ExecuteBatch(batch, requestOptions : null, operationContext : null);
            batch.Clear();
        }
        
        public static List<T> Query<T>(this CloudTable cloudTable) where T : ITableEntity, new()
        {
            return cloudTable.ExecuteQuery<T>(new TableQuery<T>().Where(string.Empty)
                                            , requestOptions : null
                                            , operationContext : null)
                             .ToList<T>();
        }
        
        /// 因為 string 條件查詢語法會以 URI 的方式進行查詢，如果條件太長，就會產生 Exception，只好透過分頁查詢的方式來處理
        public static List<T> Query<T>(this CloudTable cloudTable,string key, IEnumerable<string> values) where T : ITableEntity, new()
        {
            var result = new List<T>();
            var pagedValues = values.Chunk(30);

            foreach (var onePageValues in pagedValues)
            {
                var condition = string.Join(" or ", onePageValues.Select(k => $"{key} eq '{k}'"));
                var pagedResult = cloudTable.ExecuteQuery<T>(new TableQuery<T>().Where(condition)
                                                           , requestOptions : null
                                                           , operationContext : null);
                result.AddRange(pagedResult);
            }
            
            return result;
        }
        
        public static IEnumerable<IEnumerable<T>> Chunk<T>(this IEnumerable<T> source, int chunksize = 99)
        {
            if (source != null)
            {
                IEnumerable<T> sourceArray = source as T[] ?? source.ToArray();
                while (sourceArray.Any())
                {
                    yield return sourceArray.Take(chunksize);
                    sourceArray = sourceArray.Skip(chunksize).ToArray();
                }
            }
        }
    }
    

    public class OrderItemTest : TableEntity
    {
        public string ShopId { get; set; } //店家Guid

        public int Quantity { get; set; } // 數量

        public string ProductId { get; set; } //產品Guid

        public string PriceId { get; set; } //產品價格Guid

        public string Note { get; set; } //備註說明

        public string OrderTitle { get; set; }

        public Guid Creater { get; set; }

        public DateTime CreateOn { get; set; }

        public Guid Updater { get; set; }

        public DateTime UpdateOn { get; set; }
    }
}
```


參考資料
> https://docs.microsoft.com/en-us/azure/visual-studio/vs-storage-aspnet5-getting-started-tables
> https://docs.microsoft.com/en-us/rest/api/storageservices/querying-tables-and-entities

待 Study
> https://blogs.msdn.microsoft.com/windowsazurestorage/2010/11/06/how-to-get-most-out-of-windows-azure-tables/
