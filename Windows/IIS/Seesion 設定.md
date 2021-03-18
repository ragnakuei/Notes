# Seesion 設定

## 開啟/關閉

- IIS Management > 站台 > 工作階段狀態 > 工作階段狀態模式設定
- WebConfig > [HttpSessionState](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.sessionstate.httpsessionstate) > mode
  
  ```xml
  <configuration>
    <system.web>
      <compilation debug="true" targetFramework="4.8"/>
      <httpRuntime targetFramework="4.8"/>
      <sessionState mode="InProc" />
    </system.web>
  </configuration>
  ```
