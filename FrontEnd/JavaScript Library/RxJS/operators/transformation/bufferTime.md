# bufferTime

- 以指定數量做為 buffer 的判斷依據
- 參數
  - bufferTimeSpan - 時間區間
  - bufferCreationInterval - 間隔
  - 如果 bufferCreationInterval 小於 bufferTimeSpan 時，就可能會有重複的 next 值


```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip, range } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom, zipWith, throttleTime, debounce, buffer, bufferTime } from 'rxjs/operators';

range(1,20)
.pipe(concatMap(i => of(i).pipe(delay(300))))
.pipe(bufferTime(300, 300))
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```

