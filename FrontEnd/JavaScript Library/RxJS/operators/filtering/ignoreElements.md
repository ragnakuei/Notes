# [ignoreElements](https://rxjs.dev/api/operators/ignoreElements)

- 忽略所有 next，直接進入 complete

```js
import { of, range, timer } from 'rxjs';
import { audit, mergeMap, delay, concatMap, auditTime, distinct, filter, find, first, ignoreElements } from 'rxjs/operators';

of(1, 2, 3, 4, 5)
.pipe(ignoreElements())
.subscribe({
  next: (val) => console.log('next', val),
  complete: () => console.log('complete'),
  error: (err) => console.log('error',err),
});
```