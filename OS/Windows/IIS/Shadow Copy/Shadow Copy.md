# Shadow Copy

### 前置條件

系統要先啟用 Volume Shadow Copy 服務，在 services.msc 中可以看到 !

### 參考資料：

-   [如何啟用 ASP.NET Core 6.0 部署到 IIS 的陰影複製 (Shadow-copying) 功能 | The Will Will Web (miniasp.com)](https://blog.miniasp.com/post/2021/11/13/ASPNET-Core-6-Shadow-copying-in-IIS)
-   [ASP.NET Core 6.0 的新功能 | Microsoft Learn](https://learn.microsoft.com/zh-tw/aspnet/core/release-notes/aspnetcore-6.0?view=aspnetcore-6.0&WT.mc_id=DOP-MVP-37580#shadow-copying-in-iis)
-   https://weblog.west-wind.com/posts/2022/Nov/07/Avoid-WebDeploy-Locking-Errors-to-IIS-with-Shadow-Copy-for-ASPNET-Core-Apps
-   https://weblog.west-wind.com/posts/2024/Apr/28/ASPNET-Core-Module-with-Shadow-Copy-Not-Starting-Separate-your-Shadow-Copy-Folders
-   http://www.ipreferjim.com/2012/04/asp-net-appdomains-and-shadow-copying/

注意事項：

-   如果網站需要使用 IIS Shadow Copy 功能的話，可以
    -   預先以預設專案範本發佈
    -   設定 web.config 啟用 shadow copy 的功能
    -   發佈至測試機
    -   並於重新檢查狀態後，再開啟網站確認是否正常運作
-   如果把 shadowCopyDirectory 所指定的資料夾砍掉，目前的判斷是會每隔 2 小時會重新檢查狀態 !
    -   間隔 2 小時都是在 偶數 小時的整點
    -   判斷間隔 2 小時的方式：
        -   在 ShadowCopy 資料夾 > 按下滑鼠右鍵 > 內容 > 以前的版本 Tab > 看各修改日期的間隔
-   後續更新網站資料時，如果不需更新 web.config 的話，此功能會立即進行複製至序號 + 1 的資料夾中
    -   啟用 Shadow Copy 後，假設更新了不包含 web.config 的網站資料後，網站就掛了。
      -   解決方式是：編輯網站的 web.config，在最後面加一個空格，儲存 !
      -   AI 的回答：為什麼改 web.config 有效，IIS 對 web.config 有檔案變更通知，任何寫入都會觸發應用程式集區回收 / ANCM 重新啟動應用程式,重啟後才會重新做一次完整的 shadow copy,新版本才真正生效。

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <location path="." inheritInChildApplications="false">
    <system.webServer>
      <handlers>
        <add name="aspNetCore" path="*" verb="*" modules="AspNetCoreModuleV2" resourceType="Unspecified" />
      </handlers>
      <aspNetCore processPath="dotnet" arguments=".\AspNetCoreMvcShadowCopy.dll" stdoutLogEnabled="false" stdoutLogFile=".\logs\stdout" hostingModel="inprocess">
        <handlerSettings>
          <!-- 以下二行是 Shadow Copy 的設定 -->
          <handlerSetting name="experimentalEnableShadowCopy" value="true" />
          <handlerSetting name="shadowCopyDirectory" value="./ShadowCopyDirectory/" />
          <!-- 以下二行是 Debug Log 的設定 -->
          <handlerSetting name="debugFile" value=".\logs\aspnetcore-debug.log" />
          <handlerSetting name="debugLevel" value="FILE,TRACE" />
        </handlerSettings>
      </aspNetCore>
    </system.webServer>
  </location>
</configuration>
```
