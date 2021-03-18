# [Positional patterns](https://docs.microsoft.com/zh-tw/dotnet/csharp/whats-new/csharp-8#positional-patterns)

- 必需搭配 Deconstruct
- switch class 的每一個 case 都是對應到 Deconstruct 轉出結果

```csharp
void Main()
{
	var t = new TestClass { Id = 1, Name = "A" };
	
	TestMethod(t).Dump();
}

public class TestClass
{
	public int Id { get; set; }

	public string Name { get; set; }

    // 必需要有 Deconstruct
	public void Deconstruct(out int id, out string name) => (id, name) = (this.Id, this.Name);
}

private string TestMethod(TestClass t)
	=> t switch
	{
	    // 測試用，大小寫與其他項目不同，目前判斷應該只會跟 Deconstruct 給定的順序有關
		var (id, name) when id == 1 && name == "A" => "A1",
		var (Id, Name) when Id == 1 && Name == "A" => "A1",
		var (Id, Name) when Id == 1 && Name == "A" => "A1",
		var (Id, Name) when Id == 1 && Name == "B" => "A1",
		var (Id, Name) when Id == 1 && Name == "B" => "A1",
		var (Id, Name) when Id == 1 && Name == "C" => "A1",
		_                                          => "No Match",
	};
```