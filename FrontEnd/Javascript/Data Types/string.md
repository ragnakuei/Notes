# string


```ts
class StringHelper {
  constructor() {}

  static trimFloatEndZero(s: string): string {
    let result = this.trimEnd(s, '0');
    result = this.trimEnd(result, '.');
    return result;
  }

  static trimEnd(s: string, trim: string): string {
    while (s.slice(s.length - trim.length) === trim) {
      const lastIndex = s.lastIndexOf(trim);
      s = s.slice(0, lastIndex);
    }

    return s;
  }
}
```

#### 取最右邊 N 位

```
function rigth(n : number) : string {
  return this.slice(this.length - n);
}
```

#### 取右邊 N 位，並補上指定字元


```js
String.prototype.fillLeft = function(fill, digits) {
    const fillString = fill.repeat(digits);
    let result = fillString + this;
    return result.slice(result.length - digits);
}
```

```js
let n = 1;
n.toString().fillLeft('0', 3)
```

> '001'



