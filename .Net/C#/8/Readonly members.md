# [Readonly members](https://docs.microsoft.com/zh-tw/dotnet/csharp/whats-new/csharp-8#readonly-members)

- 用於 struct
- 用於 method ， 該 method 內不能修改的 property、field 的值 !


```csharp
public struct Test
{
	public int Id { get; private set; }

	public readonly void SetId(int newId)
	{
        // 無法寫入 Id
		Id = newId;
	}
}
```