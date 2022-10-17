# Class

- function 前方宣告不需要加上 `function`
- 只能有一個 `constructor`


```js
class Animal {
    constructor(theName) {
        this.name = theName;
        this.age = 0;
    }

    move(distanceInMeters) {
        console.log(`${this.name} ${this.age} moved ${distanceInMeters}m.`);
    }
}

var a = new Animal('Dog');
console.log(a.name);
```


### 多 constructor 的替代寫法

```js
class TestClass {
    constructor(width, height) {
     this.width = width;
        this.height = height;
    }
    
    static Square(width) {
        return new TestClass(width, width);
    }
    
    static Rectangle(width, height) {
        return new TestClass(width, height);
    }
}




const a = TestClass.Square(2);
console.log(a);


const b = TestClass.Rectangle(3, 4);
console.log(b);
```