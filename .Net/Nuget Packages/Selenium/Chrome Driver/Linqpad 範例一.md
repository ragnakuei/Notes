# Linqpad 範例一

安裝套件

```csharp
Selenium.WebDriver  
Selenium.WebDriver.ChromeDriver
```

```csharp
void Main()
{
    Login();
}

/// <summary>
/// 開啟的 url
/// </summary>
private string _url = "https://louislinebot.azurewebsites.net/Login";

/// <summary>
/// 指定 chromedriver.exe 所在 folder path
/// </summary>
private string _path = @"C:\Users\ragna\.nuget\packages\Selenium.WebDriver.ChromeDriver\83.0.4103.3900\driver\win32";

public void Login()
{
    IWebDriver driver = new ChromeDriver(_path);
    driver.Navigate().GoToUrl(_url);
    driver.Manage().Timeouts().ImplicitWait = TimeSpan.FromSeconds(10000);

    //輸入帳號
    IWebElement inputAccount = driver.FindElement(By.Name("Account"));
    inputAccount.Clear();
    inputAccount.SendKeys("20180513");

    //輸入密碼
    IWebElement inputPassword = driver.FindElement(By.Name("Passwrod"));
    inputPassword.Clear();
    inputPassword.SendKeys("123456");

    //點擊執行
    IWebElement submitButton = driver.FindElement(By.XPath("/html/body/div[2]/form/table/tbody/tr[4]/td[2]/input"));
    submitButton.Click();

    var value = driver.FindElement(By.XPath("/html/body/div[2]/form/p"));
    value.Text.Dump();

    driver.Quit();
}
```