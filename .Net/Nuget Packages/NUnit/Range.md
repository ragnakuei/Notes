# [Range](https://github.com/nunit/docs/wiki/Range-Attribute)

```csharp
[Test]
public void GivenXX_ExpectedYY([Range(1, 6, 1)] int count)
{

}
```

跟以下的語法結果一樣

```csharp
[Test]
[TestCase(1)]
[TestCase(2)]
[TestCase(3)]
[TestCase(4)]
[TestCase(5)]
[TestCase(6)]
public void GivenXX_ExpectedYY(int count)
{

}
```
