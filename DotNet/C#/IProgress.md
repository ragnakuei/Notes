# IProgress

通常用於進度條回報進度

會以另一個執行緒來呼叫某個動作

---

## 範例 1

以下面的語法來說，輸出的結果不會是 0 ~ 9，因為是各起一個不同的執行緖來執行 method

```csharp
void Main()
{
    IProgress<int> progress = new Progress<int>(Test);

    for (int i = 0; i < 10; i++)
    {
        progress.Report(i);
    }
}

public void Test(int i)
{
    i.Dump();
}
```

---

## 範例二

以下二種語法結果相同，但 callback 的指定對象不同

一個是 method，一個是 event

```csharp
IProgress<int> progress1 = new Progress<int>(Test);
```

```csharp
var progress2 = new Progress<int>();
progress2.ProgressChanged += Test2;
```

```csharp
void Main()
{
    IProgress<int> progress1 = new Progress<int>(Test);

    var progress2 = new Progress<int>();
    progress2.ProgressChanged += Test2;

    for (int i = 0; i < 10; i++)
    {
    progress1.Report(i);
    (progress2 as IProgress<int>).Report(i);
    }
}

public void Test(int i)
{
    i.Dump();
}

public void Test2(object sender, int i)
{
    $"{i:00}".Dump();
}
```

---

## 待思考

- 如果有工作需要很密集的回報時，該如何處理 ?
