# clear session after login and logout.md

二個時機點

- 執行登入語法前
- 執行登出語法後

```csharp
HttpContext.Session.Clear();
```
