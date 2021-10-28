# [takeWhile](https://rxjs.dev/api/operators/takeWhile)

- next 符合 predicate 條件的，直到第一個不符合為止，之後略過

```js
import { of, range, timer, interval } from 'rxjs';
import { audit, mergeMap, delay, concatMap, auditTime, distinct, filter, find, first, ignoreElements, last, single, skip, skipUntil, takeWhile } from 'rxjs/operators';

of(1,2,3,4,5,6)
.pipe(takeWhile(x => x < 4))
.subscribe({
  next: (val) => console.log('next', val),
  complete: () => console.log('complete'),
  error: (err) => console.log('error',err),
});
```
