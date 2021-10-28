# [raceWith](https://rxjs.dev/api/operators/raceWith)


```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith } from 'rxjs/operators';

of('first').pipe(delay(100))
.pipe(
  raceWith(
    of('second').pipe(delay(120)),
    interval(1000).pipe(mapTo('1s won!'))
  )
)
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```
