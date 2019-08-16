using System;
using System.Collections.Generic;
using System.Linq;
using BenchmarkDotNet.Attributes;
using BenchmarkDotNet.Running;

namespace ComparaerDifferentClass
{
    public class Program
    {
        public static void Main(string[] args)
        {
            BenchmarkRunner.Run<Benchmark>();
            Console.ReadLine();
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
    }

    public class TestClass
    {
        private List<Test1> t1s = new List<Test1>
                                  {
                                      new Test1
                                      {
                                          Id   = 1
                                        , Name = "A"
                                      }
                                    , new Test1
                                      {
                                          Id   = 2
                                        , Name = "B"
                                      }
                                    , new Test1
                                      {
                                          Id   = 3
                                        , Name = "C"
                                      }
                                  };

        private List<Test2> t2s = new List<Test2>
                                  {
                                      new Test2
                                      {
                                          Id   = 2
                                        , Name = "B"
                                      }
                                    , new Test2
                                      {
                                          Id   = 3
                                        , Name = "C"
                                      }
                                  };

        public Test1[] 測試項目1()
        {
            return t1s.Where(t1 => t2s.Any(t2 => t2.Id == t1.Id) == false).ToArray();
        }

        public Test1[] 測試項目2()
        {
            return T1sExceptT2s(t1s, t2s, (t1, t2) => t1.Id == t2.Id).ToArray();
        }

        private IEnumerable<T1> T1sExceptT2s<T1, T2>(List<T1> t1s, List<T2> t2s, Func<T1, T2, bool> comparer)
        {
            foreach (var t1 in t1s)
            {
                if (t2s.Any(t2 => comparer(t1, t2)) == false)
                {
                    yield return t1;
                }
            }
        }
    }

    public class Test1
    {
        public int    Id   { get; set; }
        public string Name { get; set; }
    }

    public class Test2
    {
        public int    Id   { get; set; }
        public string Name { get; set; }
    }
}