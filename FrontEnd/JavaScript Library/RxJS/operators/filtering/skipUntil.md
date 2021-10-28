# [skipUntil](https://rxjs.dev/api/operators/skipUntil)

- 在指定的時間內都略過 next

```js
import { of, range, timer, interval } from 'rxjs';
import { audit, mergeMap, delay, concatMap, auditTime, distinct, filter, find, first, ignoreElements, last, single, skip, skipUntil } from 'rxjs/operators';

interval(500)
.pipe(skipUntil(timer(1800)))
.subscribe({
  next: (val) => console.log('next', val),
  complete: () => console.log('complete'),
  error: (err) => console.log('error',err),
});
```