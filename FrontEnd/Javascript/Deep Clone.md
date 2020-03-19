# Deep Clone

## ES6 支援的做法

`var target = Object.assign({}, source);`

```js
var obj1 = { a: 10, b: 20, c: 30 };
var obj2 = Object.assign({}, obj1);
```