# bufferCount

- 以指定數量做為 buffer 的判斷依據


```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip, range } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom, zipWith, throttleTime, debounce, buffer, bufferCount } from 'rxjs/operators';

range(1,20)
.pipe(concatMap(i => of(i).pipe(delay(300))))
.pipe(bufferCount(3))
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```

