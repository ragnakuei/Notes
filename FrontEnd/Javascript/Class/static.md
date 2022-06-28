# static

```js
window.Test = class Test {
    static Hello(name) {
        return 'Hello ' + name;
    }

    static Log(msg) {
        console.log(msg);
    }
};

Test.Log(Test.Hello('TT'));
```
