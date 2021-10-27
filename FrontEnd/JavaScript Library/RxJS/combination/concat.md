# [concat](https://rxjs.dev/api/operators/concat)

依序串接 Observable

```js
import { combineAll, map, mergeMap, sequenceEqual, take } from 'rxjs/operators';
import { of, iif, interval, timer, combineLatest, concat } from 'rxjs';


concat(
  timer(0, 500).pipe(take(2)),
  timer(0, 100).pipe(take(5))
)
.subscribe(
  (val) => console.log(val),
  (err) => console.log(err),
  () => console.log('complete')
);
```

