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
