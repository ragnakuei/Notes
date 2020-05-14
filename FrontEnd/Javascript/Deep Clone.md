# Deep Clone

---

## ES6 支援的做法

`var target = Object.assign({}, source);`

```jsx
var obj1 = { a: 10, b: 20, c: 30 };
var obj2 = Object.assign({}, obj1);
```

### 透過 json 處理

```csharp
var obj1 = { body: { a: 10 } };
var obj2 = JSON.parse(JSON.stringify(obj1));
obj2.body.a = 20;

console.log(obj1); // { body: { a: 10 } } <-- 沒被改到
console.log(obj2); // { body: { a: 20 } }
console.log(obj1 === obj2); // false
console.log(obj1.body === obj2.body); // false
```

### jQuery

```csharp
var $ = require('jquery');

var obj1 = {
    a: 1,
    b: { f: { g: 1 } },
    c: [1, 2, 3]
};

var obj2 = $.extend(true, {}, obj1);
console.log(obj1.b.f === obj2.b.f); // false
```

### lodash

```csharp
var _ = require('lodash');

var obj1 = {
    a: 1,
    b: { f: { g: 1 } },
    c: [1, 2, 3]
};

var obj2 = _.cloneDeep(obj1);
console.log(obj1.b.f === obj2.b.f); // false
```