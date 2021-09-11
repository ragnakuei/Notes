# 動態給定 class 或 struct 值

```csharp
try
{
    command.CommandText = sql;
    command.Parameters.AddRange(sqlParameters);

    using (var dr = command.ExecuteReader())
    {
        var type         = typeof(T);
        var isStructType = type.IsClass == false && type.IsValueType;

        var propertyInfos = GetPropertyInfos(type);

        var dtos = new List<T>();

        if (dr.HasRows)
        {
            while (dr.Read())
            {
                T dto = new T();
                object boxObj = isStructType
                                    ? RuntimeHelpers.GetObjectValue(dto)
                                    : null;

                foreach (var propertyInfo in propertyInfos)
                {
                    var value = dr.GetValue(dr.GetOrdinal(propertyInfo.Name));

                    // 防止 propertyInfo.SetValue() 無法給定 DBNull 的值
                    if (value is DBNull)
                    {
                        value = null;
                    }

                    if (isStructType)
                    {
                        propertyInfo.SetValue(boxObj, value);
                    }
                    else
                    {
                        propertyInfo.SetValue(dto, value);
                    }
                }

                if (isStructType)
                {
                    dto = (T)boxObj;
                }

                dtos.Add(dto);
            }
        }

        return dtos;
    }
}
catch (Exception)
{
    if (command.Connection.State != ConnectionState.Closed)
    {
        command.Connection.Close();
    }

    throw;
}
```