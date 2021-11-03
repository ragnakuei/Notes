# [takeLast](https://rxjs.dev/api/operators/takeLast)

- 只抓取最後 N 個 next

```js
import { of, range, timer, interval } from 'rxjs';
import { audit, mergeMap, delay, concatMap, auditTime, distinct, filter, find, first, ignoreElements, last, single, skip, skipUntil, skipWhile, take, takeLast } from 'rxjs/operators';

of(1,2,3,4,5,6)
.pipe(takeLast(2))
.subscribe({
  next: (val) => console.log('next', val),
  complete: () => console.log('complete'),
  error: (err) => console.log('error',err),
});
```
