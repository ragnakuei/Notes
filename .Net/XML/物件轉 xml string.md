# 物件轉 xml string

## 範例

```csharp
class Program
{
    public static void Main(string[] args)
    {
        var po = new PurchaseOrder
                 {
                     ShipTo = new Address
                              {
                                  Name  = "Teresa Atkinson",
                                  Line1 = "1 Main St.",
                                  City  = "AnyTown",
                                  State = "WA",
                                  Zip   = "00000"
                              },
                     OrderDate = new DateTime(2021, 1, 5).ToLongDateString(),
                     OrderedItems = new OrderedItem[]
                                    {
                                        new OrderedItem
                                        {
                                            ItemName    = "Widget S",
                                            Description = "Small widget",
                                            UnitPrice   = 5.23m,
                                            Quantity    = 3,
                                        }
                                    },
                     SubTotal  = 15.69m,
                     ShipCost  = 12.51m,
                     TotalCost = 28.20m,
                 };

        var xmlString = XmlSerializerToString(po);
        Console.WriteLine(xmlString);
    }

    private static string XmlSerializerToString<T>(T obj)
    {
        var serializer = new XmlSerializer(typeof(T));
        var ms         = new MemoryStream();
        var writer     = new StreamWriter(ms);

        serializer.Serialize(writer, obj);
        writer.Close();

        return Encoding.UTF8.GetString(ms.ToArray());
    }
}


[XmlRoot(ElementName = "PurchaseOrder",

         // 指定 xmlns
         Namespace   = "urn:GEINV:eInvoiceMessage:C0401:3.1",
         IsNullable  = false)]
public class PurchaseOrder
{
    // 指定 xsi:schemaLocation
    // 要宣告成 public 才會處理
    [XmlAttribute(AttributeName = "schemaLocation",
                  Namespace     = XmlSchema.InstanceNamespace)]
    public string xsiSchemaLocation = "urn:GEINV:eInvoiceMessage:C0401:3.1 C0401.xsd";

    public Address ShipTo { get; set; }

    public string OrderDate { get; set; }

    [XmlArray("Items")]
    public OrderedItem[] OrderedItems { get; set; }

    public decimal SubTotal { get; set; }

    public decimal ShipCost { get; set; }

    public decimal TotalCost { get; set; }
}

public class Address
{
    [XmlAttribute]
    public string Name { get; set; }

    public string Line1 { get; set; }

    [XmlElement(IsNullable = false)]
    public string City { get; set; }

    public string State { get; set; }

    public string Zip { get; set; }
}

public class OrderedItem
{
    public string ItemName { get; set; }

    public string Description { get; set; }

    public decimal UnitPrice { get; set; }

    public int Quantity { get; set; }

    public decimal LineTotal => UnitPrice * Quantity;
}
```

## 輸出結果

```xml
<?xml version="1.0" encoding="utf-8"?>
<PurchaseOrder xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xsi:schemaLocation="urn:GEINV:eInvoiceMessage:C0401:
3.1 C0401.xsd" xmlns="urn:GEINV:eInvoiceMessage:C0401:3.1">
  <ShipTo Name="Teresa Atkinson">
    <Line1>1 Main St.</Line1>
    <City>AnyTown</City>
    <State>WA</State>
    <Zip>00000</Zip>
  </ShipTo>
  <OrderDate>2021年1月5日</OrderDate>
  <Items>
    <OrderedItem>
      <ItemName>Widget S</ItemName>
      <Description>Small widget</Description>
      <UnitPrice>5.23</UnitPrice>
      <Quantity>3</Quantity>
    </OrderedItem>
  </Items>
  <SubTotal>15.69</SubTotal>
  <ShipCost>12.51</ShipCost>
  <TotalCost>28.20</TotalCost>
</PurchaseOrder>

```