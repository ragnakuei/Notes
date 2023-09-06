# [reduce](https://developer.mozilla.org/zh-TW/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce)

```js
arr.reduce(
    callback[(accumulator, currentValue, currentIndex, array)],
    initialValue,
);
```

#### callback 第一個參數: accumulator

- 如果有給定 initialValue 的話，則 callback 中，第一次 iteration 的 accumulator 就是 initialValue
  - 常用情境：array groupby
- 如果沒有給定 initialValue 的話，則 callback 中，第一次 iteration 的 accumulator 就是 array 的第一個 element
  - 常用情境：加總


##### 範例 01

```js
const ints = [1,2,3,4,5];

const result = ints.reduce((acc,cur, _, ary) => {

	acc.push(cur * cur);
  
  return acc;

}, []);

console.log('result', result);
// result > [1, 4, 9, 16, 25]
```


#### callback 第四個參數: array

-   代表呼叫的 array 本身

##### 範例 01

```js
const data = [1, 2, 3, 4, 5];
const result = data.reduce((acc, cur, _, ary) => {
    ary.push(cur * cur);
    return ary;
}, []);

console.log(result);
// [1, 2, 3, 4, 5, 1, 4, 9, 16, 25]
```


#### initialValue


##### 未給 initialValue

```js
const ints = [1,2,3,4,5];

const result = ints.reduce((acc,cur, _, ary) => {

  return acc + cur;

});

console.log('result', result);
// result > 15
```