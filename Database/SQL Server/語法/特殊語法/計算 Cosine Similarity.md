相關名詞：

Square - 平方
Sum of square - 平方和
Magnitude - 平方和的平方根


```sql
DECLARE @askEmbedding varchar(max) = '[ 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0 ]'

SELECT *,
       [dbo].[CosineSimilarity](@askEmbedding, [E].[Embedding]) AS [CosineSimilarity]
FROM (
         VALUES (1, '[ 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0 ]'),
                (2, '[ 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1 ]'),
                (3, '[ 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0, 1.1, 1.2 ]')
     ) AS [E]([Seq], [Embedding])
```



```sql
CREATE FUNCTION [CosineSimilarity](
    @Vector1 varchar(max),
    @Vector2 varchar(max)
)
    RETURNS FLOAT
AS
BEGIN
    DECLARE @DotProduct DECIMAL(38, 36) = 0;
    DECLARE @Magnitude1 DECIMAL(38, 36) = 0;
    DECLARE @Magnitude2 DECIMAL(38, 36) = 0;
    DECLARE @CosineSimilarity FLOAT;

    -- split the vectors into rows
    WITH [Vector1] AS (
                          SELECT CONVERT(FLOAT, [Value])            AS [Value],
                                 ROW_NUMBER() OVER (ORDER BY (
                                                                 SELECT NULL
                                                             )) - 1 AS [key]
                          FROM OPENJSON(@Vector1)
                      ),
         [Vector2] AS (
                          SELECT CONVERT(FLOAT, [Value])            AS [Value],
                                 ROW_NUMBER() OVER (ORDER BY (
                                                                 SELECT NULL
                                                             )) - 1 AS [key]
                          FROM OPENJSON(@Vector2)
                      )
    SELECT @DotProduct += CONVERT(DECIMAL(20, 18), [Vector1].[Value]) * CONVERT(DECIMAL(20, 18), [Vector2].[Value]),
           @Magnitude1 += POWER(CONVERT(DECIMAL(20, 18), [Vector1].[Value]), 2),
           @Magnitude2 += POWER(CONVERT(DECIMAL(20, 18), [Vector2].[Value]), 2)
    FROM [Vector1]
    JOIN [Vector2]
         ON [Vector1].[key] = [Vector2].[key];

    SET @Magnitude1 = SQRT(@Magnitude1);
    SET @Magnitude2 = SQRT(@Magnitude2);

    IF @Magnitude1 = 0 OR @Magnitude2 = 0
        SET @CosineSimilarity = 0;
    ELSE
        SET @CosineSimilarity = @DotProduct / (@Magnitude1 * @Magnitude2);

    RETURN @CosineSimilarity;
END
GO
```