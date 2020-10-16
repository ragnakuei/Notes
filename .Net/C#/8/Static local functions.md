# [Static local functions](https://docs.microsoft.com/zh-tw/dotnet/csharp/whats-new/csharp-8#static-local-functions)

- static 掛在 method 上時，就有解耦的意圖
-

```csharp
private string Test(string s)
{
	if(ContainsA(s))
	{
		return "Contains A";
	}
	else
	{
		return "Not Contains A";
	}
	
	// static local function
	static bool ContainsA(string input)
	{
		return input.Contains("A");
	}
}
```