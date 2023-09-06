# yield 範例 01

-   些微類似 C# yield return
-   function 要以 \* 結尾
-   原本用 return 的方式，就改用 yield !
-   回傳資料型態為 generator
    -   可以 generator.next().value 分成多次逐一取值
    -   亦可以直接用 for 來直接取出所有值
-   尚不清楚使用情境，也許直接回傳 array 的可用性更高 !

```js
function* multiple_of_2(length) {
    for (let i = 1; i <= length; i++) {
        if (i % 2 === 0) {
            yield i;
        }
    }
}

let iteratorA = multiple_of_2(10);

// 逐個取出 element
console.log('iteratorA 2', iteratorA.next().value); // 2
console.log('iteratorA 4', iteratorA.next().value); // 4
console.log('iteratorA 6', iteratorA.next().value); // 6
console.log('iteratorA 8', iteratorA.next().value); // 8
console.log('iteratorA 10', iteratorA.next().value); // 10
console.log('iteratorA undefined', iteratorA.next().value); // undefined

// 上述的 iterator 已跑完，所以下面這個 loop 因為沒有 element，所以不會執行 !
for (const i of iteratorA) {
    console.log('iteratorA nothing', i);
}

iteratorA = multiple_of_2(10);
// 因為重新給定 iterator 所以下方 loop 就有 element 可以執行 !
for (const i of iteratorA) {
    console.log('iteratorA', i);
}

for (const i of multiple_of_2(10)) {
    console.log('direct call:', i);
}
```

執行結果

```
iteratorA 2: 2
iteratorA 4: 4
iteratorA 6: 6
iteratorA 8: 8
iteratorA 10: 10
iteratorA undefined: undefined
iteratorA: 2
iteratorA: 4
iteratorA: 6
iteratorA: 8
iteratorA: 10
direct call: 2
direct call: 4
direct call: 6
direct call: 8
direct call: 10
```
