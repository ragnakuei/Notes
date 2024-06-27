# JSON

### 查詢結果輸出成 JSON

#### 直接輸出成 json，不指定 Root Node Name

```sql
DECLARE @ids table
             (
                 [id] int
             )
INSERT INTO @ids
VALUES (1), (2), (3)

SELECT *
FROM @ids
FOR JSON AUTO
```

會輸出

```json
[{"id":1},{"id":2},{"id":3}]
```



#### 直接輸出成 json，並指定 Root Node Name 為 ids

```sql
DECLARE @ids table
             (
                 [id] int
             )
INSERT INTO @ids
VALUES (1), (2), (3)

SELECT *
FROM @ids
FOR JSON AUTO, ROOT('ids')
```

會輸出
```json
{"ids":[{"id":1},{"id":2},{"id":3}]}
```


#### 將查詢結果放入變數的方式

```sql
DECLARE @ids table
             (
                 [id] int
             )
INSERT INTO @ids
VALUES (1), (2), (3)

DECLARE @json nvarchar(max)

SELECT @json = (
                   SELECT [id]
                   FROM @ids
                   FOR JSON AUTO, ROOT('ids')
               )
SELECT @json
```

#### 從 json 字串讀取成 資料表

如果資料表欄位比 json  欄位少，也是可以的 !

```sql
SELECT *
FROM [prj_application_log]

DECLARE @json NVARCHAR(MAX) = N'[
  {"ID": 1, "Name": "John", "Age": 30},
  {"ID": 2, "Name": "Jane", "Age": 25},
  {"ID": 3, "Name": "Doe", "Age": 22}
]';

SELECT *
FROM OPENJSON(@json)
              WITH (
                    [ID] INT 'strict $.ID',
                    [Name] NVARCHAR(100) 'strict $.Name',
                    [Age] INT 'strict $.Age'
                  );
```