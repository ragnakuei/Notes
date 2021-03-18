# ConfigureAwait

參考資料

[.NET 程式鎖死與 SynchronizationContext](https://www.huanlintalk.com/2016/01/asyc-deadlock-in-aspbet.html)

[.NET 非同步程式小技巧：GetAwaiter().GetResult() 與 Result 的差異](https://blog.darkthread.net/blog/getawaiter-getresult-vs-result/)

## 範例

- 只要 .Result 裡面有 await ，就會卡死

- 建議改用 .GetAwaiter().GetResult()
  - 但是非同步方法內有 await，仍然會卡死

```csharp
public ActionResult Index1()
{
    // 正常
    var result = MyDownloadPage("https://tw.yahoo.com");

    return Content(result);
}

private string MyDownloadPage(string url)
{
    var content = new HttpClient().GetStringAsync(url).Result;
    
    return content;
}
```

```csharp
public ActionResult Index2()
{
    // 卡死
    var result = MyDownloadPageAsync("https://tw.yahoo.com").Result;

    return Content(result);
}

private async Task<string> MyDownloadPageAsync(string url)
{
    // 這裡會獲取當前的 SynchronizationContext 
    var content = await new HttpClient().GetStringAsync(url);
    return content;
}
```


