# 轉成 T

## json 內容

```json
{
  "Option1": "Value1",
  "Option2": 2,

  "A": {
    "A1": "AA"
  },
  "B": [
    {
      "Name": "Gandalf",
      "Age": 1000
    },
    {
      "Name": "Harry",
      "Age": 17
    }
  ]
}
```

## C# 語法

Test Case Sample

```csharp
[Test]
public void AllProperty()
{
    var target = new ConfigurationBuilder()
                .AddJsonFile("appsettings.json", false, true)
                .Build();

    var actual = target.Get<AppSettingsConfig>();

    var expected = new AppSettingsConfig()
                    {
                        Option1 = "Value1",
                        Option2 = 2,
                        A = new AOption
                            {
                                A1 = "AA"
                            },
                        B = new[]
                            {
                                new BOption
                                {
                                    Name = "Gandalf",
                                    Age  = 1000,
                                },
                                new BOption
                                {
                                    Name = "Harry",
                                    Age  = 17,
                                },
                            }
                    };

    actual.Should().BeEquivalentTo(expected);
}
```