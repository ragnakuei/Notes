# add header Cache-Control_no-store 和 Pragma_no-cache

在 Action 加上

```csharp
[ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
```

就可以了

用於有機敏資料的頁面最好 !
