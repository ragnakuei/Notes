# OnErrorResumeNext

- 阻塞式
- 當原本執行的 IObservable\<T> 出現 Exception 後，就改為執行 OnErrorResumeNext() 內的引數

```cs
var source = Observable.Range(1, 10)
                        .Do(x =>
                            {
                                // 模擬執行 Exception
                                if (x > 3)
                                {
                                    throw new Exception("Test");
                                }
                            })
                        .OnErrorResumeNext(Observable.Range(11, 3))
                        .Finally(() => Console.WriteLine("All Completed !"));

using (source.Subscribe(onNext: s => Console.WriteLine($"Subscribe Message:{s}"),
                        onError: e => Console.WriteLine(e.Message),
                        onCompleted: () => Console.WriteLine("Complete")))
{
}
```

執行結果

```
Subscribe Message:1
Subscribe Message:2
Subscribe Message:3
Subscribe Message:11
Subscribe Message:12
Subscribe Message:13
Complete
All Completed !
```