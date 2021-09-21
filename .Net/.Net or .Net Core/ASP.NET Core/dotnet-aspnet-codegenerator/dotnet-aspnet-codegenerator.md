# [dotnet-aspnet-codegenerator](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/tools/dotnet-aspnet-codegenerator)

- 以 scaffold 來建立檔案

## 語法結構

```
dotnet aspnet-codegenerator [generators] [檔案主檔名稱] [TemplateName] -m [model] -outDir [輸出資料夾]
```

- generators
  - area
  - controller
  - identity
  - razorpage
  - view

- 檔案主檔名稱

- TemplateName
  - Empty
  - Create
  - Edit
  - Delete
  - Details
  - List

- model
  - 參考的 model

- 輸出資料夾

### arguments

- -m 指定 model
- -outDir 指定輸出資料夾
- -udl 使用 default layout


範例

> dotnet aspnet-codegenerator view MyEdit Edit -m Movie -dc RazorPagesMovieContext -outDir Pages/Movies

> dotnet aspnet-codegenerator view Create Create -m OrderDto -outDir Views/Home -udl
