# [merge](https://rxjs.dev/api/index/function/merge)

- 將不同時間軸上的 Observable 合併成一個 Observable 時間軸

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap } from 'rxjs/operators';

merge(
  of(1,2,3).pipe(concatMap(x => of(x).pipe(delay(500)))),
  of(4,5,6).pipe(concatMap(x => of(x).pipe(delay(300)))),
)
.subscribe(
  (val) => console.log(val),
  (err) => console.log(err),
  () => console.log('complete')
);
```
