# 從字串轉 object

## 範例

> 這個做法在 Linqpad 上會掛掉，原因待釐清 !

```csharp
internal class Program
{
    private static string userXml = @"<root>
<Status>1</Status>
<Message>Sucess</Message>
<ErrorCode/>
<DataInfo>
    <User>U1</User>
    <User>U2</User>
</DataInfo>
</root>";

    private static string companyXml = @"<root>
<Status>1</Status>
<Message>Sucess</Message>
<ErrorCode/>
<DataInfo>
    <Company>C</Company>
</DataInfo>
</root>";


    public static void Main(string[] args)
    {
        var c = DeserializeXml<CompanyDto>(companyXml);

        var u = DeserializeXml<UserDto>(userXml);
    }

    private static T DeserializeXml<T>(string xmlStr) where T : class
    {
        XmlRootAttribute xRootu = new XmlRootAttribute();
        xRootu.ElementName = "root";
        xRootu.IsNullable  = true;
        using (var reader = new StringReader(xmlStr))
        {
            var c = (new XmlSerializer(typeof(T), xRootu)).Deserialize(reader) as T;
            return c;
        }
    }
}

public class CompanyDto
{
    public string  Status    { get; set; }
    public string  Message   { get; set; }
    public string  ErrorCode { get; set; }
    public Company DataInfo  { get; set; }
}

public class Company
{
    [XmlElement("Company")]
    public string Value { get; set; }
}

public class UserDto
{
    public string Status    { get; set; }
    public string Message   { get; set; }
    public string ErrorCode { get; set; }
    public User   DataInfo  { get; set; }
}

public class User
{
    [XmlElement("User")]
    public string[] Value { get; set; }
}
```