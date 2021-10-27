# [sequenceEqual](https://rxjs.dev/api/operators/sequenceEqual)

跟 every 有點類似，比對整個 Observable emit items 是否相等 !

```js
import { sequenceEqual } from 'rxjs/operators';
import { of } from 'rxjs';

const source = of(1, 2, 3, 4, 5)
  .pipe(
    sequenceEqual(of(1, 2, 3, 4, 5))
  )
  .subscribe(
    (val) => console.log(val),
    (err) => console.log(err),
    () => console.log('complete')
  );
```