# 字串轉 IPAddress.md

```csharp
void Main()
{
	ParseIpAndPrint("127.0.0.1");
	ParseIpAndPrint("168.95.1.1");
	ParseIpAndPrint("::1");
	ParseIpAndPrint("fec0:0:0:ffff::1%1, fec0:0:0:ffff::2%1, fec0:0:0:ffff::3%1");	
}

private void ParseIpAndPrint(string ip)
{
	var ipAddress = IPAddress.Parse(ip);

	ipAddress.ToString().Dump();

	ipAddress.AddressFamily.Dump();

	$"is IPv4:{ipAddress.AddressFamily == AddressFamily.InterNetwork}".Dump();
	
	$"is IPv6:{ipAddress.AddressFamily == AddressFamily.InterNetworkV6}".Dump();
    "".Dump();
}
```