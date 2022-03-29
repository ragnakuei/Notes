# Collation

##

以下二個的標點符號大小寫視為相同：
- Chinese_Taiwan_Stroke_CI_AS
- Chinese_Taiwan_Stroke_CS_AS

## 列出所有 Collation

```sql
SELECT name, description 
FROM sys.fn_helpcollations()
```

### 依照 Collation 排序

```sql
SELECT [str]
FROM (
         VALUES ('01'),
                ('1'),
                ('1A'),
                ('1A1'),
                ('1AA'),
                ('2'),
                ('10'),
                ('11'),
                ('12'),
                ('A')
) AS [TmpTable]([str])
ORDER BY str collate Chinese_Taiwan_Stroke_90_CI_AI_WS_SC_UTF8
```