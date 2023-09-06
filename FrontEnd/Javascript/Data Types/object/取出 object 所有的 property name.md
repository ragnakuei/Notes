# 取出 object 所有的 property name

### 方法一

```js
const object1 = {
    a: 'somestring',
    b: 42,
};

for (const [key, value] of Object.entries(object1)) {
    console.log(`${key}: ${value}`);
}
```

### 方法二

```js
const validators = this.self.options[propertyName];

for (const validator of Object.keys(validators)) {
}
```
