# ApiController

[套用 ApiController Attribute 的功能](https://blog.miniasp.com/post/2019/09/16/ASPNET-Core-22-Web-API-Tips-and-Tricks)


## 如果是從 MVC 切換過來時

可能需要調整程式 in Startup.ConfigureServices()

```csharp
// 預設不支援
services.AddMemoryCache();

// 要啟用 Session 時，就需要加
services.AddDistributedMemoryCache();
```