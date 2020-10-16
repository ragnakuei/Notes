# [Tuple patterns](https://docs.microsoft.com/zh-tw/dotnet/csharp/whats-new/csharp-8#tuple-patterns)

```csharp
void Main()
{
	Test("A",1).Dump();
	Test("A",2).Dump();
	Test("B",1).Dump();
	Test("C",3).Dump();
}
private string Test(string s, int i)
{
	return (s, i) switch
	{
		("A", 1 ) => "A1",
		("A", 2 ) => "A2",
		("A", 3 ) => "A3",
		("B", 1 ) => "B1",
		("B", 2 ) => "B2",
		("C", 1 ) => "C1",
		_         => "No Match"
	};
}
```