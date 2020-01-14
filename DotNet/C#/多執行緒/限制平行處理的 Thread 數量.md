# 限制平行處理的 Thread 數量

透過 **new ParallelOptions { MaxDegreeOfParallelism = 4 }** 就可以限制最多 4 個 Thread 來處理

```csharp
var locker = new Object();
int count = 0;
Parallel.For
    (0
     , 100
     , new ParallelOptions { MaxDegreeOfParallelism = 4 }
     , (i) =>
           {
               Interlocked.Increment(ref count);
               lock (locker)
               {
                   Console.WriteLine("Number of active threads:" + count);
                   Thread.Sleep(10);
               }
               Interlocked.Decrement(ref count);
           }
    );
```

參考資料

- [StackOverFlow](https://stackoverflow.com/questions/9538452/what-does-maxdegreeofparallelism-do)
