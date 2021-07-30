# ArrayList 轉成 xml

```csharp
void Main()
{
    var writer = new StringWriter();

    var s = new XmlSerializer(typeof(Group));

    var myGroup = new Group
    {
        ExtraInfo = new ArrayList { "A", 1 },
    };

    s.Serialize(writer, myGroup);
    writer.Close();
    Console.WriteLine(writer.ToString());

}

public class Group
{
    [XmlElement("Column1", DataType = "string", Type = typeof(string)),
     XmlElement("Column2", DataType = "int", Namespace = "http://www.cohowinery.com", Type = typeof(int))]
    public ArrayList ExtraInfo { get; set; }
}
```
