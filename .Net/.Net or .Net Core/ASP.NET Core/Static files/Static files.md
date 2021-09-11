# Static files

- 也可以做檔案的 mapping

## 允許任何檔案通過

```csharp
app.UseStaticFiles(new StaticFileOptions
                    {
                        ServeUnknownFileTypes = true
                    });
```


## 白名單做法

```csharp
new Dictionary<string, string>
    {
        [@"wwwroot\js"]  = "/js",
        [@"wwwroot\css"] = "/css",
        [@"wwwroot\lib"] = "/lib",
        [@"wwwroot\vue"] = "/vue",
    }
    .ForEach(kv => app.UseStaticFiles(new StaticFileOptions()
                                        {
                                            FileProvider = new PhysicalFileProvider(Path.Combine(env.ContentRootPath, kv.Key)),
                                            RequestPath  = new PathString(kv.Value)
                                        }));
```