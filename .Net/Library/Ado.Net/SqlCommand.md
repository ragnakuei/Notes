# SqlCommand

## 給定 SqlType 及 value 的方式

```csharp
sqlCommand.Parameters.Add("EmpNo", SqlDbType.NVarChar, 50).Value = EmpNo;

new SqlParameter("EmpNo", SqlDbType.NVarChar, 50){ Value = EmpNo }
```
