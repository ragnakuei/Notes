# Generate

-   阻塞式
-   有點類似 Linq.Aggregate()
-   引數
    -   initialState - 給定初始值
    -   condition - 判斷是否停止的條件
    -   iterate - 每次 interator 執行的動作
    -   resultSelector - 符合 condition 條件後的執行動作

#### 範例

```cs
using var subscribe = Observable.Generate(initialState: 1,
                                          condition: x => x < 10,
                                          iterate: x => x + 1,
                                          resultSelector: x => x * 2)
                                .Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s}"),
                                           onError: e => Console.WriteLine(e.Message),
                                           onCompleted: () => Console.WriteLine("Complete"))
                                .Finally(() => Console.WriteLine("All Completed !"));
```

執行結果：

```
Subscribe Message:2
Subscribe Message:4
Subscribe Message:6
Subscribe Message:8
Subscribe Message:10
Subscribe Message:12
Subscribe Message:14
Subscribe Message:16
Subscribe Message:18
Complete
All Completed !
```
