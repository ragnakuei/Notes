# Static files

- 也可以做檔案的 mapping

## 允許任何檔案通過

```csharp
app.UseStaticFiles(new StaticFileOptions
                    {
                        ServeUnknownFileTypes = true
                    });
```
