# [buffer](https://rxjs.dev/api/operators/buffer)

- 搭配 time 相關的 Observable，回傳該時段內的 next 為 array
  - 搭配 timer 就只做第一段的 buffer
  - 搭配 interval 做全部的間隔分段

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip, range } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom, zipWith, throttleTime, debounce, buffer } from 'rxjs/operators';

range(1,20)
.pipe(concatMap(i => of(i).pipe(delay(300))))
.pipe(buffer(interval(1000)))
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```