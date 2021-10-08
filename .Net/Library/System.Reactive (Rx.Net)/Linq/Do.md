# Do

Do(onNext, onError, onCompleted)

- 用來中間插入 interator Observable\<T> 的動作

#### retry 範例 + Log Exception

```cs
// 用來模擬 retry 失敗的 count
var errorCount = 0;

using var subscribe = Observable.Defer(() =>
                                        {
                                            errorCount++;
                                            if (errorCount < 3)
                                            {
                                                throw new Exception("under 3 exception");
                                            }

                                            return Observable.Return(10);
                                        })
                                .Do(onNext: i => Console.WriteLine($"Do int:{i}"),
                                    onError: e => Console.WriteLine($"Log Exception:{e.Message}"),
                                    onCompleted: () => Console.WriteLine("Do Completed"))
                                .Retry(3)
                                .Subscribe(onNext: s => Console.WriteLine($"Subscribe int:{s}"),
                                            onError: e => Console.WriteLine(e.Message), // 無法抓到每次 retry 的 Exception
                                            onCompleted: () => Console.WriteLine("Complete"));
Console.WriteLine("All Completed !");
```