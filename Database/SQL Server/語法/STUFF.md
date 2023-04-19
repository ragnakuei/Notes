# STUFF

## 參數

1. 參數是要取代的字串
1. 開始取代的 index
1. 要取代的字元數量
1. 取代的字串

#### 範例

```sql
SELECT STUFF(',123', 1, 1, '')  -- 123
SELECT STUFF(',123', 2, 1, '')  -- ,23
SELECT STUFF(',123', 2, 2, '')  -- ,3
SELECT STUFF(',123', 2, 3, '')  -- ,
```
