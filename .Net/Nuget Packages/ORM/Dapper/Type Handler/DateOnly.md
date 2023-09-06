# DateOnly

```cs
public class DapperDateOnlyHandler : SqlMapper.TypeHandler<DateOnly>
{
    // Read From Db
    public override DateOnly Parse(object? value)
    {
        if (value == null
         || value.ToString() is not {} str
         || string.IsNullOrEmpty(str))
        {
            throw new NotImplementedException();
        }

        return DateOnly.Parse(str.Replace(" 00:00:00", string.Empty));
    }

    // Write To Db
    public override void SetValue(IDbDataParameter parameter, DateOnly value)
    {
        parameter.Value  = value.ToString();
        parameter.DbType = DbType.Date;
    }
}
```