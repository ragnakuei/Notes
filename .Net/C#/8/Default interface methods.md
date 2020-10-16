# [Default interface methods](https://docs.microsoft.com/zh-tw/dotnet/csharp/whats-new/csharp-8#default-interface-methods)

- 讓 interface 可以有實作 method
- 可以用於 Property accessor 上 !
  - 但 interface 無法宣告 field，所以可以給定一個預設且無法變更值的 Property

```csharp
void Main()
{
	ITest t = new TestA();
	
	t.Id.Dump();
	
	// 如果 TestA 不實作 Id, 則 Id 值不會被改變
	t.Id = 1;
	t.Id.Dump();
	
	t.Test();
}

public interface ITest
{
	public int Id
	{
		get { return 0; }
		set { }
	}
	
	public void Test()
	{
		"Run ITest".Dump();
	}
}

public class TestA : ITest
{
	// public int Id { get; set; }

	// 如果實作了 method ，就會以實作的為主
	// public void Test()
	// {
	// 	"Run TestA".Dump();
	// }
}
```