# Create

- 阻塞式
- 可以用來將每筆資料放入 IObservable 中

#### 將 Collection 放入 IObservable 中，依序處理

```cs
var source = Observable.Create<int>(o =>
                                    {
                                        for (int i = 0; i < 10; i++)
                                        {
                                            o.OnNext(i);
                                        }

                                        o.OnCompleted();
                                        return () => Console.WriteLine("timer Disposed");
                                    });

using var dispose = source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s}"),
                                        onError: e => Console.WriteLine(e.Message),
                                        onCompleted: () => Console.WriteLine("Complete"));

Console.WriteLine("All Completed !");
```

#### 讓 Create() 裡面的物件 可以執行 Dispose

```cs
using var subscribe = Observable.Create<string>(o =>
                                                {
                                                    var timer = new System.Timers.Timer();
                                                    timer.Interval = 500;

                                                    ElapsedEventHandler timerOnElapsed = (s, e) => o.OnNext("tick");
                                                    timer.Elapsed += timerOnElapsed;

                                                    timer.Start();

                                                    return () =>
                                                            {
                                                                timer.Elapsed -= timerOnElapsed;
                                                                timer.Dispose();
                                                                Console.WriteLine("timer Disposed");
                                                            };
                                                })
                                .Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s}"),
                                            onError: e => Console.WriteLine(e.Message),
                                            onCompleted: () => Console.WriteLine("Complete"));

Thread.Sleep(2000);

Console.WriteLine("All Completed !");
```