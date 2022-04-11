# 找不到 bin 底下的 roslyn csc.exe

## 正常的情境

刪掉 bin/roslyn 資料夾，經過編譯後，會重新產生 !
- 該資料夾的來源為 `packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform.x.x.x`
- 記得看一下 packages.config 是否有該套件的項目

### 可能情境一：未安裝指定套件

安裝以下二個套件

- Microsoft.CodeDom.Providers.DotNetCompilerPlatform
- Microsoft.Net.Compilers

[參考資料](https://marcus116.blogspot.com/2018/11/net-web-api-bin-roslyn-cscexe.html)


### 可能情境二：套件資料夾路徑指錯

- Microsoft.CodeDom.Providers.DotNetCompilerPlatform

在該專案下，以關鍵字 `Microsoft.CodeDom.Providers.DotNetCompilerPlatform` 搜尋
看看指向 packages\Microsoft.CodeDom.Providers.DotNetCompilerPlatform 中的路徑是否正確

可能影響的檔案
- .csproj
- Web.config
- 
