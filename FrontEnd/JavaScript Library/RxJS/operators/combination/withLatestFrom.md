# [withLatestFrom](https://rxjs.dev/api/operators/withLatestFrom)

- 最後一個 Observable 啟動後，才會進入 next 的動作

#### 範例

- 第一個 next 是 Source (0.5s): 3 Latest From (2s): 0

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom } from 'rxjs/operators';

interval(500)
.pipe(
  withLatestFrom( interval(2000) ),
  map(([first, second]) => `Source (0.5s): ${first} Latest From (2s): ${second}` )
)
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```
