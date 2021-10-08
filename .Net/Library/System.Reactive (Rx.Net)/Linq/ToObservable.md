# ToObservable

- 阻塞式
- 將 Task 轉成 IObservable



#### 將 IEnumerable<int> 轉成 IObservable\<int>

```cs
var source = Enumerable.Range(1, 10).ToObservable();

using var dispose = source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s}"),
                                        onError: e => Console.WriteLine(e.Message),
                                        onCompleted: () => Console.WriteLine("Complete"));

Console.WriteLine("All Completed !");
```

#### 將 Task 轉成 IObservable\<Unit>

```cs
var task = Task.Factory.StartNew(() =>
                                    {
                                        for (int i = 0; i < 10; i++)
                                        {
                                            Console.WriteLine(i);
                                        }
                                    });

using var dispose = task.ToObservable()
                        .Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s}"),
                                    onError: e => Console.WriteLine(e.Message),
                                    onCompleted: () => Console.WriteLine("Complete"));

Console.WriteLine("All Completed !");
```