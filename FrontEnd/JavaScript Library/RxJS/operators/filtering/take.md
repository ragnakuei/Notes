# [take](https://rxjs.dev/api/operators/take)


```js
import { of, range, timer, interval } from 'rxjs';
import { audit, mergeMap, delay, concatMap, auditTime, distinct, filter, find, first, ignoreElements, last, single, skip, skipUntil, skipWhile, take } from 'rxjs/operators';

of(1,2,3,4,5,6)
.pipe(take(4))
.subscribe({
  next: (val) => console.log('next', val),
  complete: () => console.log('complete'),
  error: (err) => console.log('error',err),
});
```