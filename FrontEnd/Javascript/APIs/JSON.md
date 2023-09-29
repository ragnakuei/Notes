# JSON

syntax: `JSON.stringify(value[, replacer[, space]])`

用來將物件轉成 JSON 字串。

### replacer

轉成 JSON 時，可以透過 replacer 來過濾不想要的屬性。

```js
const obj = {
    a: 1,
    b: 2,
    c: 3
};

// 方式一
const json = JSON.stringify(obj, (key, value) => {
    if (key === 'b' || key === 'c') {
        return undefined;
    }

    return value;
});

// 方式二
const json2 = JSON.stringify(obj, ['b', 'c']);

console.log(json);
console.log(json2);
```


### space

用來設定縮排的空白字元。
