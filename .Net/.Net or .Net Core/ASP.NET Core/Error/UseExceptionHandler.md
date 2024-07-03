# UseExceptionHandler

有數種實作方式

### 預設，給定 Url Page

```cs
// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");

    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}
```

背後呼叫的語法是

```cs
public static IApplicationBuilder UseExceptionHandler(this IApplicationBuilder app, string errorHandlingPath)
{
    if (app == null)
    {
        throw new ArgumentNullException(nameof(app));
    }

    return app.UseExceptionHandler(new ExceptionHandlerOptions
    {
        ExceptionHandlingPath = new PathString(errorHandlingPath)
    });
}
```

### 透過 ExceptionHandlerOptions

這個可以攔截 Exception 的處理，由 ExceptionHandler 來接手後續要怎麼顯示

```cs
app.UseExceptionHandler(new ExceptionHandlerOptions
                        {
                            ExceptionHandler = async httpContext =>
                                               {
                                                   var exceptionHandlerPathFeature = httpContext.Features.Get<IExceptionHandlerPathFeature>();
                                                   var exception                   = exceptionHandlerPathFeature?.Error;

                                                   var isApi = httpContext.Request.Path.StartsWithSegments("/api");

                                                   if (isApi)
                                                   {
                                                       await httpContext.RequestServices
                                                                        .GetRequiredService<WebApiExceptionHandler>()
                                                                        .Handle(httpContext, exception);
                                                   }
                                                   else
                                                   {
                                                       await httpContext.RequestServices
                                                                        .GetRequiredService<MvcExceptionHandler>()
                                                                        .Handle(httpContext, exception);
                                                   }
                                               }
                        });
```

### 使用 Action<IApplicationBuilder>()

這個雖然可以攔截 Exception 的處理，但針對 Response Body 需要額外處理，否則會顯示 Exception 詳細的內容 ( Developer Exception Page )在頁面上 !

```cs
app.UseExceptionHandler(configure =>
                        {
                            configure.Run(async httpContext =>
                                          {
                                              var exceptionHandlerPathFeature = httpContext.Features.Get<IExceptionHandlerPathFeature>();
                                              var exception                   = exceptionHandlerPathFeature?.Error;

                                              var isApi = httpContext.Request.Path.StartsWithSegments("/api");

                                              if (isApi)
                                              {
                                                  await httpContext.RequestServices
                                                                   .GetRequiredService<WebApiExceptionHandler>()
                                                                   .Handle(httpContext, exception);
                                              }
                                              else
                                              {
                                                  await httpContext.RequestServices
                                                                   .GetRequiredService<MvcExceptionHandler>()
                                                                   .Handle(httpContext, exception);
                                              }
                                          });
                        });
```

其中額外處理 Response Body 的部份，預期需要在 MvcExceptionHandler.Handler() 加上下面的語法 !

```cs
context.Response.WriteAsync(string.Empty);
```

再次提醒，如果不加上述的語法，指定了 Http Status Code 為 404 但沒給定 Response Body，會造成 Exception !
