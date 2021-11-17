# Ping

```cs
var p = new Ping();

var dns = "8.8.8.8";

var r = p.Send(dns);

if (r.Status == IPStatus.Success)
{
    $"Reply from {r.Address}: bytes={r.Buffer.Length} time={r.RoundtripTime}ms TTL={r.Options.Ttl}".Dump();
}
```