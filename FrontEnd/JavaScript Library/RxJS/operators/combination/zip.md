# [zip](https://rxjs.dev/api/operators/zip)

- v8 會改用 zipWith
- 以各 Observable 最小的數量、一致的時間差，來執行 next
  - next 為 [ ]

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom } from 'rxjs/operators';

zip(
  of(1,2,3,4,5,6).pipe(concatMap(v => of(v).pipe(delay(1000)))),
  of(11,12,13,14,15).pipe(concatMap(v => of(v).pipe(delay(500)))),
)
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```