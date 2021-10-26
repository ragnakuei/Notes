# ContinueWith

#### 搭配 Unwrap 效能差

- 記憶體用量跟效能差很多

```cs
using System;
using System.Threading.Tasks;
using BenchmarkDotNet.Attributes;
using BenchmarkDotNet.Running;

namespace ConsoleApp8
{
    public class Program
    {
        static void Main(string[] args)
        {
            BenchmarkRunner.Run<TestClass>();

            // RunAll();
        }

        private static void RunAll()
        {
            var target = new TestClass();
            target.測試項目1_Unwrap();
            Console.WriteLine(target.Result);

            target.Result = 0;
            target.測試項目2_await().ConfigureAwait(false).GetAwaiter();
            Console.WriteLine(target.Result);
        }
    }

    [MemoryDiagnoser]
    public class TestClass
    {
        public int Result = 0;

        [Benchmark]
        public void 測試項目1_Unwrap()
        {
            Result = Bar1().Unwrap().Result;
        }

        private static Task<Task<int>> Bar1()
        {
            var originalMarker = Task.Run(() => 1);
            return originalMarker.ContinueWith((m) => m);
        }

        private static async Task<int> Bar2_1()
        {
            return await Task.FromResult(1);
        }

        private static async Task<int> Bar2_2(int i)
        {
            return await Task.FromResult(i);
        }

        [Benchmark]
        public async Task 測試項目2_await()
        {
            var t1 = await Bar2_1();
            Result = await Bar2_2(t1);
        }
    }
}
```


測試結果：
| Method           |        Mean |     Error |    StdDev |  Gen 0 | Allocated |
| ---------------- | ----------: | --------: | --------: | -----: | --------: |
| 測試項目1_Unwrap | 2,242.31 ns | 13.140 ns | 12.291 ns | 0.0420 |     264 B |
| 測試項目2_await  |    62.84 ns |  1.252 ns |  1.392 ns | 0.0229 |     144 B |


#### 範例

```cs
var cts = new CancellationTokenSource();

var task1 = Task.Run(() =>
{
    "Task1.Running".Dump();
});

var task2 = task1.ContinueWith(t =>
{
    "Task2.Running".Dump();

    // 模擬發生 Exception 的情況
    throw new Exception("Test");
});

task2.ContinueWith(t =>
{
    // task2 執行成功時才會執行的地方
    "Task2.Complete".Dump();
}, TaskContinuationOptions.OnlyOnRanToCompletion);

task2.ContinueWith(t =>
{
    // task2 執行失敗時才會執行的地方
    "Task2.Exception".Dump();
    t.Dump();
}, TaskContinuationOptions.OnlyOnFaulted);
```
