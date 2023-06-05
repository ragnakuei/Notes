# 搭配 Web Api

```cs
builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
       .AddCookie(options =>
                  {
                      // 以 response.StatusCode 401  回應，而不是 302
                      options.Events.OnRedirectToLogin = (context) =>
                                                         {
                                                             context.Response.StatusCode = 401;
                                                             return Task.CompletedTask;
                                                         };
                  });
builder.Services.AddAuthorization();

// ...

app.UseAuthentication();
app.UseAuthorization();
```