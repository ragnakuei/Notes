# 新增時，同時取出 Identity

情境：

新增主表及子表資料時，想要連同子表與主表的 id 一併以暫存表的方式取出並寫入子表 !


```sql
-- 測試前：宣告要寫入的資料表
CREATE TABLE [#TargetTable]
(
    [id]   INT IDENTITY (1, 1),
    [name] NVARCHAR(50)
);

-- 暫存資料表，用來準備寫入的資料
CREATE TABLE [#TempTable]
(
    -- 原寫入的資料的暫時關聯 ID
    [relationId] uniqueidentifier,
    [name]       NVARCHAR(50)
);
INSERT INTO [#TempTable] ([relationId], [name])
VALUES (NEWID(), N'測試1'),
       (NEWID(), N'測試2'),
       (NEWID(), N'測試3');

-- 暫存對應資料表，用來準備寫入的資料
CREATE TABLE [#TempMappingTable]
(
    -- 原寫入的資料的暫時關聯 ID
    [relationId] uniqueidentifier,
    -- 寫入後的 Identity ID
    [newId]      INT
);

-- [無效語法] 實際執行寫入並取得 Identity ID
--INSERT INTO [#TargetTable] ([name])
--OUTPUT [inserted].[id],
--       [tt].[relationId] INTO [#TempMappingTable] ([newId], [relationId])
--SELECT [tt].[name] 
--FROM [#TempTable] [tt];

-- [修正後語法] 使用 MERGE 插入並獲得插入後的 ID 與原始 relationId
MERGE INTO [#TargetTable] AS target
USING [#TempTable] AS source
ON 1 = 0
WHEN NOT MATCHED THEN
    INSERT ([name])
    VALUES (source.[name])
    OUTPUT inserted.[id], source.[relationId] INTO [#TempMappingTable] ([newId], [relationId]);


-- 查詢結果
SELECT *
FROM [#TempTable];

SELECT *
FROM [#TempMappingTable];

SELECT *
FROM [#TargetTable];

-- 測試完畢：清空上述暫存資料
DROP TABLE [#TempMappingTable];
DROP TABLE [#TempTable];
DROP TABLE [#TargetTable];
```