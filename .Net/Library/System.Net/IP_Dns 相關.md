# IP_Dns 相關

## 取得瀏覽者 IP

- _contextAccessor 為 IHttpContextAccessor

```csharp
private IPAddress IPAddress => _contextAccessor.HttpContext.Connection.RemoteIpAddress;

private IPAddress IPAddressV4
{
    get
    {
        // 如果是 IPv6
        if (IPAddress.AddressFamily == System.Net.Sockets.AddressFamily.InterNetworkV6)
        {
            return Dns.GetHostEntry(IPAddress)
                        .AddressList
                        .First(x => x.AddressFamily == System.Net.Sockets.AddressFamily.InterNetwork);
        }

        return IPAddress;
    }
}
```

