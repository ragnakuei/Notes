# 字串轉 DataTable func

- 加上 reference
  - 可以用該 **class.GetTypeInfo().Assembly** 來直接取得 Assembly 字串
- 加上 import namespace
  - 可以直接複製 **using** 的部份

```cs
async Task Main()
{
    var dt = new DataTable();
    dt.Columns.Add(new DataColumn("Id", typeof(Int32)));
    dt.Columns.Add(new DataColumn("Name", typeof(String)));


    Enumerable.Range(1, 10)
    .ForEach(i =>
    {
        var row = dt.NewRow();
        row["Id"] = i;
        row["Name"] = (char)(((int)'A' - 1) + i);
        dt.Rows.Add(row);
    });

    dt.Dump();

    var str = @"(dt, id) => {
        var row = dt.AsEnumerable().FirstOrDefault(r => r.Field<int>(""Id"") == id );
        return row.Field<string>(""Name"");
    }";

    // 加上 reference
    var references = new[] {
        typeof(object).GetTypeInfo().Assembly,
        typeof(DataTable).GetTypeInfo().Assembly,
        typeof(Enumerable).GetTypeInfo().Assembly,
        typeof(System.Data.DataTableExtensions).GetTypeInfo().Assembly
    };

    // 加上 import namespace
    var imports = new[] {
        "System",
        "System.Linq",
        "System.Collections.Generic",
        "System.Data"
    };

    var scriptOptions = ScriptOptions.Default
                                    .WithReferences(references)
                                    .WithImports(imports);

    var func = await CSharpScript.EvaluateAsync<Func<DataTable, int, string>>(str, scriptOptions);
    var name = func.Invoke(dt, 2);
    name.Dump();
}
```