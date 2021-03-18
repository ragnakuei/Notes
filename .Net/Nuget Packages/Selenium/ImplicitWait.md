# ImplicitWait

隱式等待 - 指定秒數 - 讓 FindElement 具有等待 N 秒的功能

```csharp
IWebDriver.Manage().Timeouts().ImplicitWait = TimeSpan.FromSeconds(10000);
```