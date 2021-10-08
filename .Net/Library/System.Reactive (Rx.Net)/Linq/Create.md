# Create

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