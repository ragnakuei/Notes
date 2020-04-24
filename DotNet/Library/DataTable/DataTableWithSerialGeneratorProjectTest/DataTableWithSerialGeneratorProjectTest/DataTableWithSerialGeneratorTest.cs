using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using NUnit.Framework;

namespace Tests
{
    public class DataTableWithSerialGeneratorTest
    {
        [Test]
        public void RowCount0()
        {
            var target = new DataTableWithSerialGenerator<Test>();
            var actual = target.Result;

            var expected = new DataTable();
            expected.Columns.Add("Id");
            expected.Columns.Add("Name");
            expected.Columns.Add("Serial");

            Assert.IsTrue(IsTableSame(expected, actual));
        }

        [Test]
        public void RowCount1WithNullableInt()
        {
            var tests = new List<Test2>
                        {
                            new Test2
                            {
                                Id   = null
                              , Name = "A"
                            }
                        };


            var target = new DataTableWithSerialGenerator<Test2>();
            target.AddRange(tests);
            var actual = target.Result;

            var expected = new DataTable();

            var column = new DataColumn();
            column.ColumnName  = "Id";
            column.AllowDBNull = true;
            column.DataType    = Nullable.GetUnderlyingType(typeof(Int32?));
            expected.Columns.Add(column);

            expected.Columns.Add("Name");
            expected.Columns.Add("Serial");

            var row = expected.NewRow();
            row["Id"]     = DBNull.Value;
            row["Name"]   = "A";
            row["Serial"] = 1;
            expected.Rows.Add(row);

            Assert.IsTrue(IsTableSame(expected, actual));
        }

        [Test]
        public void RowCount2()
        {
            var tests = new List<Test>
                        {
                            new Test
                            {
                                Id   = 1
                              , Name = "A"
                            }
                          , new Test
                            {
                                Id   = 2
                              , Name = "B"
                            }
                        };

            var target = new DataTableWithSerialGenerator<Test>();
            target.AddRange(tests);
            var actual = target.Result;


            var expected = new DataTable();
            expected.Columns.Add("Id");
            expected.Columns.Add("Name");
            expected.Columns.Add("Serial");

            var row = expected.NewRow();
            row["Id"]     = 1;
            row["Name"]   = "A";
            row["Serial"] = 1;
            expected.Rows.Add(row);

            row           = expected.NewRow();
            row["Id"]     = 2;
            row["Name"]   = "B";
            row["Serial"] = 2;
            expected.Rows.Add(row);

            Assert.IsTrue(IsTableSame(expected, actual));
        }

        private bool IsTableSame(DataTable t1, DataTable t2)
        {
            if (t1 == null)
                return false;
            if (t2 == null)
                return false;
            if (t1.Rows.Count != t2.Rows.Count)
                return false;

            if (t1.Columns.Count != t2.Columns.Count)
                return false;

            if (t1.Columns.Cast<DataColumn>().Any(dc => !t2.Columns.Contains(dc.ColumnName)))
            {
                return false;
            }

            for (int i = 0 ; i <= t1.Rows.Count - 1 ; i++)
            {
                if (t1.Columns.Cast<DataColumn>().Any(dc1 => t1.Rows[i][dc1.ColumnName].ToString() != t2.Rows[i][dc1.ColumnName].ToString()))
                {
                    return false;
                }
            }

            return true;
        }
    }


    public class Test
    {
        public int    Id   { get; set; }
        public string Name { get; set; }
    }

    public class Test2
    {
        public int?   Id   { get; set; }
        public string Name { get; set; }
    }
}