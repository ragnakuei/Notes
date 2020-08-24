# EnableRetryOnFailure

[參考資料](https://docs.microsoft.com/en-us/dotnet/architecture/microservices/implement-resilient-applications/implement-resilient-entity-framework-core-sql-connections#execution-strategies-and-explicit-transactions-using-begintransaction-and-multiple-dbcontexts)

當啟用了 `EnableRetryOnFailure` 後，會需要使用不同的語法

要從原本的語法

```csharp
private static void SeedDataWithEntityModels(string[] args)
{
    var contextFactory = new TestDbContextFactory();

    using (var dbContext = contextFactory.CreateDbContext(args))
    {
        using (var trans = dbContext.Database.BeginTransaction())
        {
            try
            {
                dbContext.TestTable.AddRange(SeedDataStore.TestTables);
                dbContext.SaveChanges();

                trans.Commit();
            }
            catch (Exception e)
            {
                trans.Rollback();
                throw e;
            }
        }
    }
}
```

改成

```csharp
private static void SeedDataWithEntityModels(string[] args)
{
    var contextFactory = new TestDbContextFactory();

    using (var dbContext = contextFactory.CreateDbContext(args))
    {
        var strategy = dbContext.Database.CreateExecutionStrategy();
        strategy.Execute(() =>
                            {
                                using (var trans = dbContext.Database.BeginTransaction())
                                {
                                    try
                                    {
                                        dbContext.TestTable.AddRange(SeedDataStore.TestTables);
                                        dbContext.SaveChanges();

                                        trans.Commit();
                                    }
                                    catch (Exception e)
                                    {
                                        trans.Rollback();
                                        throw e;
                                    }
                                }
                            });
    }
}
```
