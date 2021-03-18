# 測試：Partial()引數中的Model、ViewData，效能比較

備註：RenderPartial() 無回傳值，待確認如何測試

```csharp
@{
    var times = Enumerable.Range(0, 100);
    var times2 = Enumerable.Range(0, 10);
    var watch = new System.Diagnostics.Stopwatch();
    long elapsedMs = 0; ;
    MvcHtmlString mhs;
    //以上可事先宣告

    foreach (var item2 in times2)
    {
        watch.Restart();
        //進行測試
        foreach (var item in times)
        {
            //此處放測試的部份
            mhs = Html.Partial("_PartialCustomer");        
            //mhs = Html.Partial("_PartialCustomer", null, new ViewDataDictionary { });
        }
        //測試結束
        watch.Stop();
        elapsedMs = watch.ElapsedMilliseconds;
        <text>Time Cost：@(elapsedMs)</text>
        <br />
    }

}
```

結論：測不出差異