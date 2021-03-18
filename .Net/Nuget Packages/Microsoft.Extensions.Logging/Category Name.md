# Category Name

預設會以 type.FullName 來做為 Category Name 的顯示

例：

```
info: WebApplication.Controllers.HomeController[0]
      Log Information
```

info: 後面的就是 Category Name

## 更改 Category Name

1. 原本 DI ILogger\<T> 改為 DI ILoggerFactory
2. 透過 ILoggerFactory.CreateLogger(`Category Name`) 來指定 Category Name 後，就會得到 ILogger
3. 透過 上述的 ILogger 來取代原本 DI 的 ILogger 就可以了 !
