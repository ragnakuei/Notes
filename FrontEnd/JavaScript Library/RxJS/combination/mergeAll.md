# [mergeAll](https://rxjs.dev/api/operators/mergeAll)

- 可以調整 concurrent thread 數量

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll } from 'rxjs/operators';

const source = interval(0).pipe(take(5));

source
  .pipe(
    map(val => source.pipe(delay(500),
                           map(v => `val:${val} v:${v}`),
                           take(3))),

    // concurrent thread 數量，如果給定 5，就會同時 5 個並行
    mergeAll(1)
  )
.subscribe(
  (val) => console.log(val),
  (err) => console.log(err),
  () => console.log('complete')
)
```