# CookieAuthenticationEvents

## OnRedirectToReturnUrl

注意：

```
如果有在 Controller.Action 中是以 return RedirectToAction() 方式回傳
就會以上述的設定為主，而忽略 OnRedirectToReturnUrl 的設定 (實際上仍然有執行)

如果要避免這個狀況，而統一使用 OnRedirectToReturnUrl 的設定
只需要在 Controller.Action 中 return View() 回傳即可 !
```

Startup.ConfigureServices()

```csharp
services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
        .AddCookie(options =>
                    {
                        options.LoginPath          = "/Account/Login";
                        options.LogoutPath         = "/Account/Logout";
                        options.AccessDeniedPath   = "/Account/AccessDenied";
                        options.ReturnUrlParameter = "returnUrl";

                        options.Events = new CookieAuthenticationEvents
                                        {
                                            OnRedirectToReturnUrl = context =>
                                                                    {
                                                                        // 做記錄
                                                                        // Console.WriteLine("OnRedirectToReturnUrl");
                                                                        // Console.WriteLine(context.Response.StatusCode);
                                                                        // Console.WriteLine(context.RedirectUri);

                                                                        context.Response.Headers["Location"] = context.RedirectUri;
                                                                        context.Response.StatusCode          = 302;

                                                                        // 與上面二行的執行結果相同
                                                                        // context.Response.Redirect(context.RedirectUri);

                                                                        return Task.CompletedTask;
                                                                    },
                                                    };
                               });
```

