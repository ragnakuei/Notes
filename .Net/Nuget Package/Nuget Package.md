# Nuget Package


## [建立包含 pdb 的 nuget package](https://docs.microsoft.com/zh-tw/dotnet/core/tools/csproj#includesymbols)

在 .csproj 中加上 `IncludeSymbols` 的宣告，並給定 true

輸出目錄下會多出 `ProjectName.symbols.nupkg` 的檔案

 
## [包含 Source Code](https://docs.microsoft.com/zh-tw/dotnet/core/tools/csproj#includesource)

在 .csproj 中加上 `IncludeSource` 的宣告，並給定 true

編譯後，在 `ProjectName.symbols.nupkg` 的檔案內，就會多一個 src 的資料夾，裡面就是 source code 
