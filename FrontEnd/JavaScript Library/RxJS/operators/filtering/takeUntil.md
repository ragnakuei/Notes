# [takeUntil](https://rxjs.dev/api/operators/takeUntil)

- 在指定的時間內都 next，之後的都略過

```js
import { of, range, timer, interval } from 'rxjs';
import { audit, mergeMap, delay, concatMap, auditTime, distinct, filter, find, first, ignoreElements, last, single, skip, takeUntil } from 'rxjs/operators';

interval(500)
.pipe(takeUntil(timer(1800)))
.subscribe({
  next: (val) => console.log('next', val),
  complete: () => console.log('complete'),
  error: (err) => console.log('error',err),
});
```