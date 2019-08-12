<font face="微軟正黑體">

# 透過檔名取得對應的 ContentType

給前端的檔案，可能會因為後端的判斷條件會有不同的檔案類型，可以在 Response Header 給定對應的 Content Type 

範例：
```csharp
Console.WriteLine(MimeMapping.GetMimeMapping("a.txt"));
Console.WriteLine(MimeMapping.GetMimeMapping("a.xls"));
Console.WriteLine(MimeMapping.GetMimeMapping("a.xlsx"));
Console.WriteLine(MimeMapping.GetMimeMapping("a.zip"));
```

執行結果如下：
```
text/plain
application/vnd.ms-excel
application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
application/x-zip-compressed
```

參考資料：[C# 小技巧 - 不必再靠 switch case 副檔名決定 ContentType 囉](https://blog.darkthread.net/blog/mimemapping-getmimemapping/)

</font>