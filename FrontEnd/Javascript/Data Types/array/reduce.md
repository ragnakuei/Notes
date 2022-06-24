# [reduce](https://developer.mozilla.org/zh-TW/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce)

```js
arr.reduce(
    callback[(accumulator, currentValue, currentIndex, array)],
    initialValue,
);
```

#### 第四個參數: array

-   如果需要在原始資料加工，而不影響既有的 interator，可以使用 array 參數

##### 範例 01

-   傳入 array 的值為 [1, 2, 3, 4, 5]
-   結果為 [1, 2, 3, 4, 5, 1, 4, 9, 16, 25]
-   initialValue 要給定，才會讓第一次進入的 cur 為第一個元素 !

```js
const data = [1, 2, 3, 4, 5];
const result = data.reduce((acc, cur, _, ary) => {
    ary.push(cur * cur);
    return ary;
}, []);
console.log(result);
```
