# [Switch expressions](https://docs.microsoft.com/zh-tw/dotnet/csharp/whats-new/csharp-8#switch-expressions)

```csharp
void Main()
{
	GetValueStatus(Test.Ok).Dump();
	GetValueStatus(Test.Cancel).Dump();
	GetValueStatus(Test.Other).Dump();
}

private string GetValueStatus(Test t)
=> t switch
{
	Test.Ok     => "Ok",
	Test.Cancel => "Cancel",
	_           => throw new NotImplementedException(),
};

//private string GetValueStatus(Test t)
//{
//	return t switch
//	{
//		Test.Ok     => "Ok",
//		Test.Cancel => "Cancel",
//		_           => throw new NotImplementedException(),
//	};
//}

public enum Test
{
	Ok,
	Cancel,
	Other,
}
```