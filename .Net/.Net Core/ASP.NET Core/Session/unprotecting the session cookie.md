# unprotecting the session cookie

在 Startup.Configure() 中，改用以下語法

目的是：為了避免共用 Cookie 名稱

### 解法一

- options.Cookie.Name 每個開發網站，都要不同的名稱 !

```csharp
services.AddSession(options =>
                    {
                        options.Cookie.Name = "Web.Session.LatestNews";
                        options.IdleTimeout = TimeSpan.FromDays(1);

                        // options.Cookie.Expiration   = TimeSpan.FromDays(1);
                        options.Cookie.SameSite     = SameSiteMode.Strict;
                        options.Cookie.SecurePolicy = CookieSecurePolicy.Always;
                        options.Cookie.IsEssential  = true;
                        options.Cookie.HttpOnly     = true;
                    });
```

### 解法二

- 或是從 SessionOptions.CookieBuilder 指定不同的名稱 !

```csharp
app.UseSession(new SessionOptions
                {
                    Cookie = new CookieBuilder
                            {
                                Name = ".AspNetCore.Session.LatestNews"
                            }
                });
```
