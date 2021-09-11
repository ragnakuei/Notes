# 設定 struct property 的值

```csharp
void Main()
{
	var a = new A();

	object boxedObject = RuntimeHelpers.GetObjectValue(a);

	typeof(A).GetProperty(nameof(A.Name)).SetValue(boxedObject, "Z");

	boxedObject.Dump();
	
	a = (A)boxedObject;
	
	a.Dump();
}

public struct A
{
	public string Name { get; set; }
}
```
