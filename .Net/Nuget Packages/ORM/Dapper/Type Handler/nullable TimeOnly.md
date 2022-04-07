# nullable TimeOnly

```cs
public class DapperNullableTimeOnlyHandler : SqlMapper.TypeHandler<TimeOnly?>
{
    // Read From Db
    public override TimeOnly? Parse(object? value)
    {
        if (value == null
         || value.ToString() is not string str
         || string.IsNullOrEmpty(str))
        {
            return null;
        }

        return TimeOnly.Parse(str);
    }

    // Write To Db
    public override void SetValue(IDbDataParameter parameter, TimeOnly? value)
    {
        parameter.Value  = value?.ToString();
        parameter.DbType = DbType.Time;
    }
}
```