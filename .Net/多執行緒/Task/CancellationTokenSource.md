# CancellationTokenSource

## 設定 Cancel 的 Event

```cs
var cts = new CancellationTokenSource();

// 給定 Cancel 的 Event
cts.Token.Register (() => "Cancel Task".Dump());

var source = Observable.Interval(TimeSpan.FromMilliseconds(200));

source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s}"),
                        onError: e => Console.WriteLine(e.Message),
                        onCompleted: () => Console.WriteLine("Complete"),
                        cts.Token);
                        
Thread.Sleep(2000);

cts.Cancel();

"Completed".Dump();
```

執行結果

```
Subscribe Message:0
Subscribe Message:1
Subscribe Message:2
Subscribe Message:3
Subscribe Message:4
Subscribe Message:5
Subscribe Message:6
Subscribe Message:7
Subscribe Message:8
Cancel Task
Completed
```


## 設定 Timeout 的方式

單位是 milliseconds

1. 第一種

    ```csharp
    CancellationTokenSource cts = new CancellationTokenSource(100);
    ```

2. 第二種

    ```csharp
    CancellationTokenSource cts = new CancellationTokenSource();
    cts.CancelAfter(100);
    ```
