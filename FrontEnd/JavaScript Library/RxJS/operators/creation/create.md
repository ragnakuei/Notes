# create

### 範例一
```js
import { Observable } from 'rxjs';

const hello = Observable.create(function(observer) {
  observer.next('Hello');
  observer.next('World');
});

const subscribe = hello.subscribe(val => console.log(val));
```

### 範例二

```js
import { Observable } from 'rxjs';

const evenNumbers = Observable.create(function(observer) {
  let value = 0;

  const interval = setInterval(() => {
    if (value % 2 === 0) {
      observer.next(value);
    }
    value++;
  }, 500);

  // unsubscribe 時才會執行 return 的 function
  return () => clearInterval(interval);
});
const subscribe = evenNumbers.subscribe(val => console.log(val));

setTimeout(() => {
  subscribe.unsubscribe();
}, 5000);
```