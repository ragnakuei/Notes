# 讓 Reqeust 讀取另一個檔案

```csharp
HttpContext.Current.RewritePath(newPath);
```

注意：
- 用 Server.Transfer(newPath) 就不會保留 Session

