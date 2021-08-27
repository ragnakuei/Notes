# Publish

-   https://docs.microsoft.com/en-us/dotnet/core/deploying/

-   https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/directory-structure

-   [Publish an ASP.NET Core app to IIS](https://docs.microsoft.com/zh-tw/aspnet/core/tutorials/publish-to-iis)

-   [Host ASP.NET Core on Windows with IIS](https://docs.microsoft.com/zh-tw/aspnet/core/host-and-deploy/iis/)

## IIS 範例

-   執行指令 `dotnet publish --configuration Release`
-   至訊息所提示的 solution/project/bin/Release/{target framework}/publish/ 中
-   將所有資料複製至 IIS folder 中

## 發佈至 IIS

[參考資料](https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/iis/?view=aspnetcore-3.1)

1. 安裝 .NET Core Hosting Bundle
1. publish
1. 問題：放到 IIS 上之後，開啟首頁，發生 `ASP.NET Core 3.1 - HTTP Error 500.30 - ANCM In-Process Start Failure` 錯誤
   - [解法](###%20改成%20outofprocess)
1. 至 [這裡](https://dotnet.microsoft.com/download/dotnet-core/3.1) 下載以下安裝程式並安裝
   - .NET Core Runtime 3.1.10 - Windows - x64
   - .NET Core Desktop Runtime 3.1.10 - Windows - x64
   - ASP.NET Core Runtime 3.1.10 - Windows - x64
   - ASP.NET Core Runtime 3.1.10 - Windows - Hosting Bundle

### debug 相關

https://marcus116.blogspot.com/2019/05/netcore-aspnet-core-http-error-50030.html


### 改成 outofprocess

1. 開啟發佈後的 web.config
2. 把以下的 hostingModel 從 inprocess
   ```xml
   <aspNetCore processPath=".\AspNetCoreSample.exe" stdoutLogEnabled="false" stdoutLogFile=".\logs\stdout" hostingModel="inprocess" />
   ```
   
   改成 OutOfProcess
   
   ```xml
   <aspNetCore processPath=".\AspNetCoreSample.exe" stdoutLogEnabled="false" stdoutLogFile=".\logs\stdout" hostingModel="OutOfProcess" />
   ```
