# 執行 sql 語法.md

[Execution strategies and transactions](https://docs.microsoft.com/en-us/ef/core/miscellaneous/connection-resiliency#execution-strategies-and-transactions)

為避免預到以下錯誤訊息：

> InvalidOperationException: The configured execution strategy 'SqlServerRetryingExecutionStrategy' does not support user initiated transactions. Use the execution strategy returned by 'DbContext.Database.CreateExecutionStrategy()' to execute all the operations in the transaction as a retriable unit.

需要套用以下語法

```csharp
var seedSql = new SeedData().Get();

var contextFactory = new TestContextFactory();

using (var dbContext = contextFactory.CreateDbContext(args))
{
    var strategy = dbContext.Database.CreateExecutionStrategy();

    strategy.Execute(() =>
                        {
                            using (var context = new TestContextFactory().CreateDbContext(args))
                            using (var transaction = context.Database.BeginTransaction())
                            {
                                try
                                {
                                    context.Database.ExecuteSqlRaw(seedSql);

                                    transaction.Commit();
                                }
                                catch (Exception e)
                                {
                                    Console.WriteLine(e.Message);
                                    transaction.Rollback();
                                }
                            }
                        });
}
```