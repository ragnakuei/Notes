# 實作(二) - 簡單套用Controller

在Views/Controller裡新增view，檔名為：OnlineUserCount.cshtml

```csharp
<span style="color:red">線上人數：8888</span>
```

在Controller裡，新增Action

```csharp
public ActionResult OnlineUserCount()
{
		return PartialView();
}
```

執行後的結果

/GuestBooks/OnlineUserCount

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/da5b9cc1-b3b0-4691-a19a-f7d03512f31a/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/da5b9cc1-b3b0-4691-a19a-f7d03512f31a/Untitled.png)

Controller/Action回傳PartialView()時
不會套用_ViewStart.cshtml裡的Layout設定~!!