# [Null-coalescing assignment](https://docs.microsoft.com/zh-tw/dotnet/csharp/whats-new/csharp-8#null-coalescing-assignment)

當變數本身是 null，就給定右邊的值

```csharp
string s = null;
s ??= "Test";
s.Dump();

s ??= "Apple";
s.Dump();
```