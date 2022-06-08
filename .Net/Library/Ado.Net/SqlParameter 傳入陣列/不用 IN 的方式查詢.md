# 不用 IN 的方式查詢

-   不取代文字

```cs
/// <summary>
/// 給定 Colleciton 至 SqlParameters 中
/// <remarks>
/// 要注意 SqlParameters 上限為 1200 個參數 !
/// </remarks>
/// </summary>
private string AddArrayParameter(SqlParameterCollection sqlParam,
                                 string                 tableColumn,
                                 string                 parameterName,
                                 object[]               values)
{
    var result     = new StringBuilder(" AND (");

    var orConditions = values.Select((value, index) =>
                                    {
                                        var sqlParameterName = string.Format("@{0}{1}", parameterName, index);

                                        var orCondition = string.Format(" {0} = {1} ", tableColumn, sqlParameterName);

                                        sqlParam.Add(new SqlParameter(sqlParameterName, value));

                                        return orCondition;
                                    });
    result.AppendLine(string.Join(" OR ", orConditions));

    result.Append(")");

    return result.ToString();
}
```
