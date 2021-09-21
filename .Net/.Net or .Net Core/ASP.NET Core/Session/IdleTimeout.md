# IdleTimeout

指的是將東西放進 Session 的閒置逾時時間，不是指 Session 本身 !

該 Property 的宣告如下：

[資料來源](https://github.com/aspnet/Session/blob/9e4b6a5e4a8d4c789b627a37b0342dad45c87b6c/src/Microsoft.AspNetCore.Session/SessionOptions.cs#L34)

```csharp
/// <summary>
/// The IdleTimeout indicates how long the session can be idle before its contents are abandoned. Each session access
/// resets the timeout. Note this only applies to the content of the session, not the cookie.
/// </summary>
public TimeSpan IdleTimeout { get; set; } = TimeSpan.FromMinutes(20);
```
