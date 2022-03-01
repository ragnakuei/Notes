# 達成 類似 Dictionary 的做法

### 語法

```ts
{[key: TKey] : TValue}
```

TKey ： key 的資料型態
TKey ： value 的資料型態


#### 範例一

```ts
const numbers = [1,2,3,1,2,1,3,4];

const numberDict : { [key: number]: number } = {};

for(const n of numbers) {
    if(numberDict[n]) {
        numberDict[n]++;
    } else {
        numberDict[n] = 1;
    }
}

console.log(numberDict);
```