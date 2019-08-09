using System.Data;
using Dapper;
using FluentAssertions;
using NUnit.Framework;
using ObjectToDynamicParameters;

namespace TestProject1
{
    public class ToDynamicParameters_Test
    {
        [SetUp]
        public void Setup()
        {
        }

        [Test]
        public void Test1()
        {
            var target = new Test
                         {
                             Id   = 1
                           , Name = "A"
                         };
            var actual = target.ToDynamicParameters();

            var expected = new DynamicParameters();
            expected.Add("Id", 1);
            expected.Add("Name", "A", size: 20);
            
            // 因為無法比對 value、size，所以無法進行測試
            actual.Should().BeEquivalentTo(expected);
        }
    }

    public class Test
    {
        [CustomDbType(DbType.Int32)]
        public int Id { get; set; }
        
        [CustomDbType(DbType.String, 20)]
        public string Name { get; set; }
    }

 
}