<font face="微軟正黑體">

# 設定不 Track 的方式

```csharp
services.AddDbContext<DemoDbContext>(
    options => options
                .UseSqlServer(Configuration.GetConnectionString("DemoDb"))
                // 下面這行語法
                .UseQueryTrackingBehavior(QueryTrackingBehavior.NoTracking));

```

</font>