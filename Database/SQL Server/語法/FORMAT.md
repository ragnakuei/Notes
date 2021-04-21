# FORMAT

## 數字格式

### 科學符號

- [格式 format 與 C# ToString() 一致](https://docs.microsoft.com/zh-tw/dotnet/standard/base-types/custom-numeric-format-strings#the-e-and-e-custom-specifiers)

```sql
DECLARE @f FLOAT = 0.001
SELECT FORMAT(@f, '0.00e+0'),
       FORMAT(@f, '0.000E+00')
```

