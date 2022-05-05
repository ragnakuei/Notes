# Pattern Matching

### 範例一

```csharp
static void Main(string[] args)
{
    var employees = new List<Employee>
    {
        new Employee { Id = 1, Name = "Johnny" },
        new Employee { Id = 2, Name = "Mary" },
        new Employee { Id = 3 },
        new Employee { Name = "Tom" },
    };

    var employeeNames = Filter(employees);
    Console.WriteLine(string.Join("\r\n", employeeNames.Select(e => $"{e.Id}, {e.Name}")));
}

private static IEnumerable<(int Id, string Name)> Filter(List<Employee> employees)
{
    foreach (var employee in employees)
    {
        if(employee is { Id: int id, Name: var name })  // 使用 var 則為允許 null 型態
        {
            yield return (id, name);
        }
    }
}
```

原本 `使用 var 則為允許 null 型態` 要改成 `不允許 null 型態` 有二種解法

1. 改成明確型別
    > if(employee is { Id: int id, Name: string name })
1. 加上 != null 判斷
    > if(employee is { Id: int id, Name: var name } && name != null)

[參考資料](https://dotblogs.com.tw/supershowwei/2019/09/30/120134)

### 範例二

左邊承接的變數，一定要用明確型別，用 var 會無法編譯 !

```cs
public Fruit Fruit { get; set; }
public string WhatFruit => Fruit switch
{
  Apple _ => "This is an apple",
  _ => "This is not an apple"
};
```
