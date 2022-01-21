# [Deconstruction](https://docs.microsoft.com/zh-tw/archive/blogs/msdntaiwan/c7-new-features#desconstruction-)

- 定義物件如何 "拆解" 為多個獨立的變數。
- 或稱 `deconstructor`

    - [C# 7 分解式](https://www.huanlintalk.com/2017/04/c-7-deconstruction-syntax.html)

> 拆解後原物件仍然存在。

## 語法： tuple

```csharp
void Main()
{
    int i1 = 0;
    int i2 = 0;

    (i1, i2) = Test();
    i1.Dump();
    i2.Dump();

    var (i3, i4) = Test();
    i3.Dump();
    i4.Dump();

    (var i5, var i6) = Test();
    i5.Dump();
    i6.Dump();
}

private (int i1, int i2) Test()
{
    return (i1 : 1, i2 : 2);
}

```


## 語法： class

```csharp
void Main()
{
    var p = new Person("John", "Quincy", "Adams", "Boston", "MA");

    var (fName1, lName1, city1, state1) = p;
    
    fName1.Dump();
    lName1.Dump();
    city1.Dump();
    state1.Dump();

    "------------------------------".Dump();

    var (fName2, lName2, city2) = p;
    fName2.Dump();
    lName2.Dump();
    city2.Dump();
}

public class Person
{
    public string FirstName { get; set; }
    public string MiddleName { get; set; }
    public string LastName { get; set; }
    public string City { get; set; }
    public string State { get; set; }

    public Person(string fname, string mname, string lname,
                  string cityName, string stateName)
    {
        FirstName = fname;
        MiddleName = mname;
        LastName = lname;
        City = cityName;
        State = stateName;
    }

    // Return the first and last name.
    public void Deconstruct(out string fname, out string lname)
    {
        fname = FirstName;
        lname = LastName;
    }

    public void Deconstruct(out string fname, out string mname, out string lname)
    {
        fname = FirstName;
        mname = MiddleName;
        lname = LastName;
    }

    public void Deconstruct(out string fname, out string lname,
                            out string city, out string state)
    {
        fname = FirstName;
        lname = LastName;
        city = City;
        state = State;
    }
}
```