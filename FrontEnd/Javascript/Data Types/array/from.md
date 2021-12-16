# from

```js
Array.from(arrayLike, mapFn, thisArg)
```

```js
Array.from('123')
Array.from('123', x => x * 2)
Array.from(['a','b','c'], x => x + '1')
Array.from(['a','b','c'], (v, i) => v + i.toString())
Array.from({ length : 50 }, function(x) { return this.initial; }, { initial : 1 })
```


#### arrayLike

目前可以定以下幾種語法

```js
'123' 會自動轉成 char array
[ ] by pass 傳遞
{ length : N } 給定 N length 的 array
```

#### mapFn

等於 Array.map() 

#### thisArg

注意：要帶上這個參數，mapFn 就不能用 arrow function express，因為會吃不到 this

```js
Array.from([1,2,3], function(i) {
   console.log('this', this);
   return i + this.additional;
}, { additional : 1 })
```


#### 應用

```js
const range = (start, stop, step) => Array.from({ length: (stop - start) / step + 1}, (_, i) => start + (i * step));

// Generate numbers range 0..4
range(0, 4, 1);
// [0, 1, 2, 3, 4]
```