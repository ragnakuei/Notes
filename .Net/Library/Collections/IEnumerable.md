# IEnumerable

- 本質是 iterator，意思是不會有儲存值的功能，而是保留了取值的方式 !
- 上述說的特性是指 `lazy loading`
- 

## IEnumerable\<T>

### Lazy Loading

- GetData() 裡面，各個 element 的輸出，是在 `after LINQ` 後才輸出的
- 實際上的輸出時機是在需要跟 result 要資料時 !

```csharp
void Main()
{
    var data = GetData();
    
    "after GetData()".Dump();
    
    var result = from i in data
                 where i % 2 == 0
                 select i;
    
    "after LINQ".Dump();
    
    result.Dump();
}

public IEnumerable<int> GetData()
{
    "1".Dump();
    yield return 1;
    
    "2".Dump();
    yield return 2;
    
    "3".Dump();
    yield return 3;
    
    "4".Dump();
    yield return 4;
    
    "5".Dump();
    yield return 5;
}
```

### yield return

- 可以在 yield return 上下中斷點，然後 step by step debug 來看執行的順序

```csharp
void Main()
{
    var a = GetData();
    a.Dump();
}

public IEnumerable<int> GetData()
{
    yield return 1;
    yield return 2;
    yield return 3;
    yield return 4;
    yield return 5;
}
```

### IEnumerable\<T> 視為產生資料的方式

- 輸出的二次結果，值都不同
- 雖然是以父類型式回傳，但在使用的意圖上，會有所差異

```csharp
void Main()
{
    var a = GetData();
    a.Dump();
    a.Dump();
}

public IEnumerable<dynamic> GetData()
{
    return Enumerable.Range(1, 10)
                     .Select(i => new 
                     {
                        Id = i,
                        CreateTime = DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss fffffff"),
                     });
}
```

輸出的二次結果，值都相同

```csharp
void Main()
{
    var a = GetData();
    a.Dump();
    a.Dump();
}

public IEnumerable<dynamic> GetData()
{
    return Enumerable.Range(1, 10)
                     .Select(i => new 
                     {
                        Id = i,
                        CreateTime = DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss fffffff"),
                     })
                     // 多了這一行轉成 Array
                     .ToArray;
}
```

### 手寫迴圈範例一

```csharp
public static class Helper
{
    public static T MaxElement<T>(this IEnumerable<T> source,
                                    Func<T, T, T>       func)
    {
        using (var iter = source.GetEnumerator())
        {
            // 先以第一個做為該欄位最大值的元素
            var maxElement = default(T);

            if (iter.MoveNext())
            {
                maxElement = iter.Current;
            }

            while (iter.MoveNext())
            {
                maxElement = func.Invoke(maxElement, iter.Current);
            }

            return maxElement;
        }
    }
}
```

### 手寫迴圈範例二

[Github 連結](https://github.com/ragnakuei/ReplaceOnce/commit/706d4b3388317c24b4ee78c176fd5ca10b6969f6#diff-fa20421de30d4b93626ea7a25aed71d977ef605fd9a79b5744ede12a9afa2b03)