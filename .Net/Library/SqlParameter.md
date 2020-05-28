# SqlParameter

## Entity Framework

給定明確型別的方式

```csharp

// 精簡寫法，可能會有參數嗅探的問題
new SqlParameter("@filter", myFilter)

// 明確指定型別，最佳寫法
new SqlParameter(parameterName: "@id", dbType: SqlDbType.Int) { Value = 1 }

// 這個寫法也可以   
new SqlParameter(parameterName: "@id", value:  1) { SqlDbType = SqlDbType.Int }
```

[參考資料](https://stackoverflow.com/questions/40781928/sqlparameter-is-already-contained-by-another-sqlparametercollection-ef-sqlquer)
