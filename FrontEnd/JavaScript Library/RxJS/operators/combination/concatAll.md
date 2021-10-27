# [concatAll](https://rxjs.dev/api/operators/concatAll)

依序串接 Observable

```js
import { of, iif, interval, timer, combineLatest, concat } from 'rxjs';
import { combineAll, map, mergeMap, sequenceEqual, take, concatAll } from 'rxjs/operators';

of (
  timer(0, 1000).pipe(take(2)),
  timer(0, 100).pipe(take(5))
)
.pipe(concatAll())
.subscribe(
  (val) => console.log(val),
  (err) => console.log(err),
  () => console.log('complete')
);
```
