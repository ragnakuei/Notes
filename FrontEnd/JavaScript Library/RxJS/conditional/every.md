# [every](https://rxjs.dev/api/operators/every)

回傳是否每個 emit 值都符合條件 !

```js
import { every } from 'rxjs/operators';
import { of } from 'rxjs';

const source = of(1, 2, 3, 4, 5)
  .pipe(
      every((val) => val % 2 === 0)
  )
  .subscribe(
    (val) => console.log(val),
    (err) => console.log(err),
    () => console.log('complete')
  );

```