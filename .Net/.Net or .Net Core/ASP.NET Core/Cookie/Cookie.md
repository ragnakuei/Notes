# Cookie

##  新增 Cookie 語法

```csharp
HttpContext.Response.Cookies.Append(dto.Key,
                                    dto.Value,
                                    new CookieOptions
                                    {
                                        // Domain      = null,
                                        // Path        = null,
                                        // Expires  = DateTimeOffset.Now.AddMinutes(10),
                                        Secure   = true,
                                        SameSite = SameSiteMode.Strict,
                                        HttpOnly = true,
                                        // MaxAge      = null,
                                        // IsEssential = false
                                    });
```

### CookieOptions

- Expires
  - 如果有指定，就是[指定過期時間](./Expires.md#expires-設定為指定時間)
  - 如果沒有指定，就是[綁定 Session](./Expires.md#expires-設定為-session)


