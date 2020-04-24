# decimal

## [精準度](https://docs.microsoft.com/zh-tw/sql/t-sql/data-types/precision-scale-and-length-transact-sql)

```sql
DECLARE @a decimal(20, 8)=1000.00000001
    ,@b decimal(20, 8)=0.123456789
    ,@c decimal(20, 8)=0.00000001

SELECT SQL_VARIANT_PROPERTY(@a, 'BaseType')  AS BaseType
     , SQL_VARIANT_PROPERTY(@a, 'Precision') AS Precision
     , SQL_VARIANT_PROPERTY(@a, 'Scale')     AS Scale

SELECT SQL_VARIANT_PROPERTY(@a * @b, 'BaseType')  AS BaseType
     , SQL_VARIANT_PROPERTY(@a * @b, 'Precision') AS Precision
     , SQL_VARIANT_PROPERTY(@a * @b, 'Scale')     AS Scale

SELECT SQL_VARIANT_PROPERTY(@a * @b * @c, 'BaseType')  AS BaseType
     , SQL_VARIANT_PROPERTY(@a * @b * @c, 'Precision') AS Precision
     , SQL_VARIANT_PROPERTY(@a * @b * @c, 'Scale')     AS Scale
```

上述語法執行後會得到下面的結果

| BaseType | Precision | Scale |
| -------- | --------- | ----- |
| decimal  | 20        | 8     |
| decimal  | 38        | 13    |
| decimal  | 38        | 6     |


有效位數算法

```markdown
(20,8)
    - 整數 12，小數 8

(20,8) * (20,8) => (38,13)
    - 整數 12 + 12 + 1 = 25
    - 小數 為總數 ( 20 + 20 => 超過 38 => 壓回 38 ) 再減整數 25 => 13

(20,8) * (20,8) * (20,8) => (38,6)
    - 整數 12 + 12 + 12 + 1 = 37
    - 小數 為總數 ( 20 + 20 + 20 => 超過 38 => 壓回 38  ) 再減整數 37 => 1 => 因為小數位數不能小於 6， 所以 => 6
```

除連結內的有效位數算法外，重點觀念有二個

1. 結果有效位數及小數位數的絕對最大值為 38。 當結果有效位數大於 38 時，會縮小至 38，並會縮減對應的小數位數，以防止截斷結果的整數部分。 在乘法或除法等某些案例中，為保持十進位有效位數，將不會縮減小數位數因數 (雖然可能會引發溢位錯誤)。
1. 若小數位數小於 6 且整數部分大於 32，則小數位數便不會變更。

### 可能解法

注意：在實際儲存數值的`有效位數比較小`時，才可以用這個做法。如果實際儲存數值的`有效位數比較大`時，就很容易出現小數被捨去的情況 !!

```sql
SELECT SQL_VARIANT_PROPERTY(Cast(@a * @b as decimal(20,8)) * @c, 'BaseType')  AS BaseType
     , SQL_VARIANT_PROPERTY(Cast(@a * @b as decimal(20,8)) * @c, 'Precision') AS Precision
     , SQL_VARIANT_PROPERTY(Cast(@a * @b as decimal(20,8)) * @c, 'Scale')     AS Scale
```

上述語法執行後會得到下面的結果

| BaseType | Precision | Scale |
| -------- | --------- | ----- |
| decimal  | 38        | 13    |

就可以得到比較正確的結果


