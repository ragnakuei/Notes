# value object 自訂格式化

## 範例

- 只能用在 .Net Framework 的環境，無法用於 .Net Core / .Net 的環境
- 在 XML Serialize 時，將 int 轉成指定格式化的字串，此範例為 D10

```csharp
class Program
{
    static void Main(string[] args)
    {
        var dto = new TestDTO
                    {
                        TestProperty = 100,
                    };

        var xml = XmlSerializerToString(dto);
        Console.WriteLine(xml);
    }

    private static string XmlSerializerToString<T>(T obj)
    {
        using (var ms = new MemoryStream())
        {
            var serializer = new XmlSerializer(typeof(T));
            var writer     = new StreamWriter(ms);

            serializer.Serialize(writer, obj);
            writer.Close();

            var xmlSerializerToString = Encoding.UTF8.GetString(ms.ToArray());
            return xmlSerializerToString;
        }
    }
}

public class TestDTO
{
    [XmlElement(Type = typeof(string))]
    public StringDto<int> TestProperty { get; set; }
}

public class StringDto<T> where T : IConvertible
{
    private T _value;

    public StringDto()
    {
    }

    public StringDto(T value)
    {
        _value = value;
    }

    public static implicit operator StringDto<T>(T value) => new StringDto<T>(value);

    public static implicit operator StringDto<T>(string _) => throw new NotImplementedException();

    public static explicit operator string(StringDto<T> str) => str.ToString();

    public override string ToString()
    {
        switch (Type.GetTypeCode(typeof(T)))
        {
            case TypeCode.Int32:
                return ((int)Convert.ChangeType(_value, typeof(int))).ToString("D10");
            default:
                return _value.ToString();
        }
    }
}
```