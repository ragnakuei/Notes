# PadLeft

將字串放入至指定的長度中，並靠右對齊

---

## 範例一：保留空白

```csharp
class Program
{
    static void Main(string[] args)
    {
        var people = new List<Person>
        {
            new Person{ Id = 1, Name="A" },
            new Person{ Id = 11, Name="AB" },
            new Person{ Id = 111, Name="ABC" },
            new Person{ Id = 1111, Name="ABCD" },
            new Person{ Id = 11111, Name="ABCDE" },
        };

        foreach (var p in people)
        {
            Console.WriteLine($"{p.Id.ToString().PadLeft(10)}:{p.Name}");
        }
    }
}

public class Person
{
    public int Id { get; set; }
    public string Name { get; set; }
}
```

輸出內容：

```
         1:A
        11:AB
       111:ABC
      1111:ABCD
     11111:ABCDE
```

---

## 範例二：空白給定指定的字元

```csharp
1.ToString().PadLeft(4, '0').Dump();
12.ToString().PadLeft(4, '0').Dump();
123.ToString().PadLeft(4, '0').Dump();
1234.ToString().PadLeft(4, '0').Dump();
```

```
0001
0012
0123
1234
```