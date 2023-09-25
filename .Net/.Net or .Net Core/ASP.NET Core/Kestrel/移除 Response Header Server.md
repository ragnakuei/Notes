# 移除 Response Header Server

注意：下面這個設定，會造成 IIS / IIS Express 無法正常啟動，請勿隨意使用。

```cs
builder.WebHost.UseKestrel(option => option.AddServerHeader = false);
```