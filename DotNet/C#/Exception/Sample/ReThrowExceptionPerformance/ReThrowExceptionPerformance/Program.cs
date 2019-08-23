using System;
using BenchmarkDotNet.Attributes;
using BenchmarkDotNet.Running;

namespace ReThrowExceptionPerformance
{
    public class Program
    {
        public static void Main(string[] args)
        {
            BenchmarkRunner.Run<Benchmark>();
            Console.ReadLine();
        }
    }

    [MemoryDiagnoser]
    //[InliningDiagnoser]
    //[TailCallDiagnoser]
    public class Benchmark
    {
        private readonly TestClass _benchClass = new TestClass();

        [Benchmark]
        public void 測試項目1() => _benchClass.測試項目1();

        [Benchmark]
        public void 測試項目2() => _benchClass.測試項目2();
    }

    public class TestClass
    {
        private readonly Random _random;
        
        public string 測試項目1()
        {
            try
            {
                throw new Exception("message");
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }

        public string 測試項目2()
        {
            try
            {
                try
                {
                    throw new Exception("message");
                }
                catch (Exception e)
                {
                    throw e;
                }
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }
    }
}