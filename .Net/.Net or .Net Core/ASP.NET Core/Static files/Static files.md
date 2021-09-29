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

- 發佈後，對應的資料夾要存在，才不會導致應用程式啟動失敗 !

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

## 開放指定副檔名

```csharp
// 讓 asp.net core 可以開放讀取指定副檔名之檔案
var extensionProvider = new FileExtensionContentTypeProvider();
extensionProvider.Mappings.Add(".vue", "text/plain");
app.UseStaticFiles(new StaticFileOptions
                    {
                        FileProvider        = new PhysicalFileProvider(Path.Combine(new []{ env.ContentRootPath, "wwwroot", "vue" })),
                        RequestPath         = new PathString("/vue"),
                        ContentTypeProvider = extensionProvider
                    });
```