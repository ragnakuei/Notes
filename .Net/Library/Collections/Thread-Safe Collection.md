# Thread-Safe Collection

#### 爭議：Array Thread Safe 的境境

情境：
- 用不同 Thread 讀取 Array 內的所有元素，並進行更新
- 不用 Thread 不會讀取到相同位置的元素

其中比較 Crtiail 的點是
- 因為不會重複讀取相同位置的元素，所以可以認定是 Thread Safe

#### Thread-Safe 操作 Array\<int>

```cs
private readonly int _collectionSize = 10;

async Task Main()
{
    var ints = Enumerable.Range(0,_collectionSize).ToArray();
    ints.Dump();

    var tasks = Enumerable.Range(1, 1000000)
    .Select(e => Task.Factory.StartNew(() =>
    {
        UpdateDynamic(ints);

        // 如果要做這個動作，就會被視為 不 Thread-Safe，但是程式不會報錯 !
        CheckArray(ints);
    }));

    await Task.WhenAll(tasks);
}

private readonly Random _random = new Random();

private void UpdateDynamic(int[] ints)
{
    var randomIndex = _random.Next(0, ints.Length);

    var randomValue = _random.Next(0, ints.Length);

    ints[randomIndex] = randomValue;
}

private void CheckArray(int[] ints)
{
    for (int i = 0; i < ints.Length; i++)
    {
        if (i != ints[i])
        {
            $"{i} != ints[{i}] <= {ints[i]}".Dump();
        }
    }
}
```

#### Thread-Safe 操作 List\<int>

- 直接存取 index ，每個 Thread 存取不同的 index

```cs
private readonly int _collectionSize = 10;

async Task Main()
{
    var ints = Enumerable.Range(0, _collectionSize).ToList();
    ints.Dump();

    var tasks = Enumerable.Range(1, 1000000)
    .Select(e => Task.Factory.StartNew(() =>
    {
        UpdateDynamic(ints);

        // 如果要做這個動作，就會被視為 不 Thread-Safe，但是程式不會報錯 !
        // CheckArray(ints);
    }));

    await Task.WhenAll(tasks);
}

private readonly Random _random = new Random();

private void UpdateDynamic(IList<int> ints)
{
    var randomIndex = _random.Next(0, ints.Count);

    var randomValue = _random.Next(0, ints.Count);
    
    ints[randomIndex] = randomValue;
}

private void CheckArray(IList<int> ints)
{
    for (int i = 0; i < ints.Count; i++)
    {
        if (i != ints[i])
        {
            $"{i} != ints[{i}] <= {ints[i]}".Dump();
        }
    }
}
```



```cs
async Task Main()
{
    var ints = new List<int>();

    var tasks = Enumerable.Range(1, 1000)
    .Select(e => Task.Factory.StartNew(() =>
    {
        AddDynamic(ints);
        ints.Dump();
    }));

    await Task.WhenAll(tasks);
}

private readonly Random _random = new Random();
private readonly int _min = 0;
private readonly int _max = 10;

private void AddDynamic(IList<int> lst)
{
    var randomValue = _random.Next(_min, _max);

    lst.Add(randomValue);
}
```

```cs
async Task Main()
{
    var ints = new Dictionary<int, int>();

    var tasks = Enumerable.Range(1, 1000)
    .Select(e => Task.Factory.StartNew(() =>
    {
        AddDynamic(ints);
        ints.Dump();
    }));

    await Task.WhenAll(tasks);
}

private readonly Random _random = new Random();
private readonly int _min = 0;
private readonly int _max = 10;

private void AddDynamic(Dictionary<int, int> dict)
{
    var randomIndex = _random.Next(_min, _max);

    var randomValue = _random.Next(_min, _max);

    // $"dict[{randomIndex}] = {randomValue}".Dump("Start");
    dict[randomIndex] = randomValue;
    // $"dict[{randomIndex}] = {randomValue}".Dump("End");
}
```

```cs
async Task Main()
{
    var ints = new ConcurrentDictionary<int, int>();

    var tasks = Enumerable.Range(1, 1000)
    .Select(e => Task.Factory.StartNew(() =>
    {
        AddDynamic(ints);
        ints.Dump();
    }));

    await Task.WhenAll(tasks);
}

private readonly Random _random = new Random();
private readonly int _min = 0;
private readonly int _max = 10;

private void AddDynamic(ConcurrentDictionary<int, int> dict)
{
    var randomIndex = _random.Next(_min, _max);

    var randomValue = _random.Next(_min, _max);

    // $"dict[{randomIndex}] = {randomValue}".Dump("Start");
    dict[randomIndex] = randomValue;
    // $"dict[{randomIndex}] = {randomValue}".Dump("End");
}
```


