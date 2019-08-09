using BenchmarkDotNet.Attributes;
using BenchmarkDotNet.Running;
using System;
using System.Collections.Generic;
using System.Linq;

namespace GroupBySelectVsGroupBy
{
    class Program
    {
        static void Main(string[] args)
        {
            var summary = BenchmarkRunner.Run<TestRunner>();
        }
    }

    [ClrJob, MonoJob, CoreJob] // 可以針對不同的 CLR 進行測試
    [MinColumn, MaxColumn]
    [MemoryDiagnoser]
    public class TestRunner
    {
        private readonly TestClass _test = new TestClass();

        private readonly CategoryItem[] _data;

        public TestRunner()
        {
            _data = new[]
                    {
                        new CategoryItem
                        {
                            Category = 1
                          , Item     = "A"
                        }
                      , new CategoryItem
                        {
                            Category = 1
                          , Item     = "A"
                        }
                      , new CategoryItem
                        {
                            Category = 2
                          , Item     = "B"
                        }
                      , new CategoryItem
                        {
                            Category = 3
                          , Item     = "C"
                        }
                    };
        }

        [Benchmark]
        public void GroupBySelect() => _test.GroupBySelect(_data);

        [Benchmark]
        public void GroupBy() => _test.GroupBy(_data);
    }

    public class TestClass
    {
        public List<MySubitem> GroupBySelect(CategoryItem[] data)
        {
            return data.GroupBy(d => d.Category)
                       .Select(kv => new MySubitem
                                     {
                                         Category = kv.Key
                                       , SubItem  = kv.Select(v => v.Item).ToList()
                                     }).ToList();
        }

        public List<MySubitem> GroupBy(CategoryItem[] data)
        {
            return data.GroupBy(x => x.Category
                              , (key, group) => new MySubitem
                                                {
                                                    Category = key
                                                  , SubItem  = group.Select(y => y.Item).ToList()
                                                }).ToList();
        }
    }

    public class CategoryItem
    {
        public int    Category { get; set; }
        public string Item     { get; set; }
    }

    public class MySubitem
    {
        public int          Category { get; set; }
        public List<string> SubItem  { get; set; }
    }
}