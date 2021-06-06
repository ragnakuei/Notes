# SqlCommand

## 給定 SqlType 及 value 的方式

```csharp
sqlCommand.Parameters.Add("EmpNo", SqlDbType.NVarChar, 50).Value = EmpNo;

sqlCommand.Parameters.Add(new SqlParameter("EmpNo", SqlDbType.NVarChar, 50)
                          { 
                              Value = EmpNo 
                          });


sqlCommand.Parameters..Add(new SqlParameter("MeasureValue01", SqlDbType.Decimal)
                           {
                               Value = detailDto.MeasureValue01;
                               Precision = 18;
                               Scale = 10;
                           });
```
