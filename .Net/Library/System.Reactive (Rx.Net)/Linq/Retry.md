# Retry

#### 範例一

```cs
// 用來模擬 retry 失敗的 count
var count = 0;

using var subscribe = Observable.Create<int>(obsever =>
                                             {
                                                 count++;
                                                 if (count < 3)
                                                 {
                                                     throw new Exception("throw exception");
                                                 }
 
                                                 obsever.OnNext(count);
                                                 obsever.OnCompleted();
                                                 return Disposable.Create(() => Console.WriteLine ("observer has unsubscribe"));
                                             })
                                    // 如果到達 retry 次數時，就會拋出最後一次的 exception
                                .Retry(3)
                                .Subscribe(onNext: s => Console.WriteLine($"int:{s}"),
                                           onError: e => Console.WriteLine(e.Message),   // 無法抓到每次 retry 的 Exception
                                           onCompleted: () => Console.WriteLine("Complete"));
Console.WriteLine("All Completed !");
```

#### 範例二

retry 前加上 Do ，就可以做到 log on exception + retry N 次 的功能 !

```cs
// 用來模擬 retry 失敗的 count
var errorCount = 0;

using var subscribe = Observable.Create<int>(o =>
                                        {
                                            errorCount++;
                                            if (errorCount < 3)
                                            {
                                                throw new Exception("under 3 exception");
                                            }

                                            o.OnNext(10);
                                            return Disposable.Create(() => Console.WriteLine ("observer has unsubscribe"));
                                        })
// using var subscribe = Observable.Defer(() =>
//                                         {
//                                             errorCount++;
//                                             if (errorCount < 3)
//                                             {
//                                                 throw new Exception("under 3 exception");
//                                             }

//                                             return Observable.Return(10);
//                                         })
                                .Do(onNext: i => Console.WriteLine($"Do int:{i}"),
                                    onError: e => Console.WriteLine($"Log Exception:{e.Message}"),
                                    onCompleted: () => Console.WriteLine("Do Completed"))
                                .Retry(3)
                                .Subscribe(onNext: s => Console.WriteLine($"Subscribe int:{s}"),
                                            onError: e => Console.WriteLine(e.Message), // 無法抓到每次 retry 的 Exception
                                            onCompleted: () => Console.WriteLine("Complete"));
Console.WriteLine("All Completed !");
```