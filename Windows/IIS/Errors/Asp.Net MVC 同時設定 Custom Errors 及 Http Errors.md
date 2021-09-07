# Asp.Net MVC 同時設定 Custom Errors 及 Http Errors

## 在未設定 Application_Error Redirect 至指定頁面的前提下

```xml
<system.webServer>
    <httpErrors errorMode="Custom" defaultResponseMode="Redirect">
    	<remove statusCode="403" />
    	<error statusCode="403" path="/Error/NotFound" responseMode="ExecuteURL" />
    	<remove statusCode="404" />
    	<error statusCode="404" path="/Error/NotFound" responseMode="ExecuteURL" />
    	<remove statusCode="500" />
    	<error statusCode="500" path="/Error/NotFound" responseMode="ExecuteURL" />
    </httpErrors>
</system.webServer>
<system.web>
    <compilation debug="true" targetFramework="4.5" />
    <httpRuntime targetFramework="4.5" />
    <customErrors defaultRedirect="/Error/NotFound" mode="On">
        <error statusCode="400" redirect="/Error/NotFound" />
        <error statusCode="403" redirect="/Error/NotFound" />
        <error statusCode="404" redirect="/Error/NotFound" />
        <error statusCode="500" redirect="/Error/NotFound" />
    </customErrors>
</system.web>
```

情境：

-   輸入 `/a/b` 則觸發 customErrors
-   輸入 `/a/b/c` 則觸發 customErrors
-   輸入 `/a/b/c/d` 則觸發 httpErrors
-   輸入 `/a` 疑似同時觸發 httpErrors 及 customErrors
-   輸入 `/ab` 則觸發 httpErrors

## 要求統一顯示同樣錯誤頁面

-   必須停用 [被阻擋的 Url 會直接顯示 404.8](../RequestFiltering/HiddenSegments/被阻擋的%20Url%20會直接顯示%20404.8.md)
    因為 IIS 預設會將指定的路徑以 404.8 來回應，這個部份不會再經過上述 error 的處理 !
-   再將上述被停用的 HiddenSegments 改由 [Url Rewrite](../URL%20Rewrite/範例.md) 來處理
-   [Route 找不到，統一導到錯誤頁面](../../../.Net/.Net%20Framework/ASP.NET/Global.asax.cs.md#Route%20%E6%89%BE%E4%B8%8D%E5%88%B0%EF%BC%8C%E7%B5%B1%E4%B8%80%E5%B0%8E%E5%88%B0%E9%8C%AF%E8%AA%A4%E9%A0%81%E9%9D%A2)
