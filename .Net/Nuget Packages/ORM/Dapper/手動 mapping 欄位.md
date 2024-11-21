# 手動 mapping 欄位

使用情境

-   查詢結果欄位有特殊字元，無法對應至 C# Property !

缺點

-   資料型態的轉型就要自己做了 !

```cs
var queryResult = _dbConnection.Query("sp",
                                      sqlParameters,
                                      commandType: CommandType.StoredProcedure);

IEnumerable<SpDTO> result = queryResult.Cast<IDictionary<string, object>>()
                                       .Select(dict => new SpDTO
                                                       {
                                                           姓名 = dict["姓名"]?.ToString(),
                                                           日期起 = dict["日期(起)"]?.ToString(),
                                                       });
```


### 動態做法：轉成 Column 跟 資料

提醒：直接將 Dapper 查詢結果，以 Json 回傳即可，js 可透過 JSON.parse() 轉成物件 及 Object.keys() 取得欄位名稱，這樣就不用做這麼多事情了 !

方便後續用在 html 上 !


```cs
void Main()
{
	var connectionString = @"";

	var sqlConnection = new SqlConnection(connectionString);

	var sql = @"
SELECT *
FROM (
         VALUES (1, 2, 3),
                (4, 5, 6),
                (7, 8, 9)
     ) AS [t] ([a], [b], [c])
	";

	var queryResult = sqlConnection.Query(sql).ToDynamicDTO();
	queryResult.Dump();
}

public static class DapperExtension
{
	public static DTO ToDynamicDTO(this IEnumerable<dynamic> source)
	{
		var queryResult = source.Cast<IDictionary<string, Object>>();
		//queryResult.Dump();

		var dto = new DTO
		{
			Columns = queryResult.First().Keys.ToList(),
			Data = queryResult.ToList(),
		};

		//dto.Dump();

		//dto.ToJson(new JsonSerializerOptions
		//{
		//	WriteIndented = true,
		//}).Dump();

		return dto;
	}
}

public class DTO
{
	public List<string> Columns { get; set; }

	public List<IDictionary<string, Object>> Data { get; set; }
}
```