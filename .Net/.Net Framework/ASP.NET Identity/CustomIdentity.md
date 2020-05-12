# CustomIdentity

### 預備知識

[Owin 套用範例](https://www.notion.so/2502c7a49e3a41b2995da85dda6c95c5)

### 安裝套件

Nuget 套件

```xml
Install-Package Microsoft.Owin
Install-Package Microsoft.Owin.Host.SystemWeb
Install-Package Microsoft.AspNet.Identity.Owin
Install-Package Microsoft.Owin.Security.Cookies

// Microsoft.AspNet.Identity.EntityFramework
Microsoft.AspNet.Identity.Owin.zh-Hant (繁體中文)
```

研究到一半，先停止

原因：Asp.Net Identity 和 Entity Framework  綁死，缺乏彈性