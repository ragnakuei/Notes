# [last](https://rxjs.dev/api/operators/last)

- 只輸出最後一個 

```js
import { of, range, timer } from 'rxjs';
import { audit, mergeMap, delay, concatMap, auditTime, distinct, filter, find, first, ignoreElements, last } from 'rxjs/operators';

of(1, 2, 3, 4, 5)
.pipe(last())
.subscribe({
  next: (val) => console.log('next', val),
  complete: () => console.log('complete'),
  error: (err) => console.log('error',err),
});
```