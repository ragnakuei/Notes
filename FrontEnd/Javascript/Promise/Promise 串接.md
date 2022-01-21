# Promise 串接

```js
new Promise(resolve => {
    resolve(1);
}).then(v => {
    return new Promise(resolve => {
        resolve(v + 1);
    })
}).then(v => {
    console.log(v);
});
```