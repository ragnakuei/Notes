# Trait

用來 Group Test Case

> Visual Studio Test Explorer 可用 **Trait:"Category"** 來過濾只顯示指定的 Category 資料

```csharp
[Fact]
[Trait("Category", "Value1")]
public void Test1()
{
    Assert.True(true);
}

[Fact]
[Trait("Category", "Value2")]
public void Test2()
{
    Assert.True(true);
}
```
