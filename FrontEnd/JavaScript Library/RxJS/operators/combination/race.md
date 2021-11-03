# [race](https://rxjs.dev/api/operators/race)

- v8 會改成 raceWith
- Observable 裡面，只執行最一開始先執行的 next

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo } from 'rxjs/operators';

race(
  of('first').pipe(delay(100)),
  of('second').pipe(delay(120)),
  interval(1000).pipe(mapTo('1s won!')),
)
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```

