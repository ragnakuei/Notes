# Scan

-   阻塞式
-   幾乎等於 js 的 Array.reduce()
-   執行步驟
    -   以第一個 element 直接執行 onNext，不經過 Scan 指定的 Func
    -   第二個 element 會經過 Scan 指定的 Func

#### 範例

給定**五個** element ，但 Scan 只會執行**四次** !

```cs
using var subscribe = Observable.Range(2, 5)
                                .Scan((x, y) =>
                                        {
                                            Console.WriteLine($"X:{x} Y:{y}");
                                            return x + y;
                                        })
                                .Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s}"),
                                            onError: e => Console.WriteLine(e.Message),
                                            onCompleted: () => Console.WriteLine("Complete"));

Console.WriteLine("All Completed !");
```

執行結果

```
Subscribe Message:2
X:2 Y:3
Subscribe Message:5
X:5 Y:4
Subscribe Message:9
X:9 Y:5
Subscribe Message:14
X:14 Y:6
Subscribe Message:20
Complete
All Completed !
```
