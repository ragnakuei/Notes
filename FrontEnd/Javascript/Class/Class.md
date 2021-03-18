# Class

- function 前方宣告不需要加上 `function`


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