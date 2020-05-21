# 增加 View 全域 using namespace 的方式

在 ~/Views/web.config 中

```xml
  <system.web.webPages.razor>
    <host factoryType="System.Web.Mvc.MvcWebRazorHostFactory, System.Web.Mvc, Version=5.2.4.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35" />
    <pages pageBaseType="System.Web.Mvc.WebViewPage">
      <namespaces>
        <add namespace="System.Web.Mvc" />
        <add namespace="System.Web.Mvc.Ajax" />
        <add namespace="System.Web.Mvc.Html" />
        <add namespace="System.Web.Routing" />

        <!-- 想要增加 View 全域 using namespace 可以加在這 -->
        <add namespace="AuthorizePracticeByRole.Helpers" />
      </namespaces>
    </pages>
  </system.web.webPages.razor>
```
