# flatMap.md

- 類似 C# LINQ 的 SelectMany 的效果 !

```js
var objAry = [
    {
        id1: 1,
        data: [
            {
                id2: 11,
            },
            {
                id2: 12,
            },
        ],
    },
];

objAry.flatMap((i1) => i1.data.flatMap((i2) => i2.id2));
```
