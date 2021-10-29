# [bufferWhen](https://rxjs.dev/api/operators/bufferWhen)

- 可以視為給定 bufferTime 相同數值的情況

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip, range } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom, zipWith, throttleTime, debounce, buffer, bufferCount, bufferTime, bufferToggle, bufferWhen } from 'rxjs/operators';

range(1,20)
.pipe(concatMap(i => of(i).pipe(delay(300))))
.pipe(bufferWhen( x => interval(750) ))
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```