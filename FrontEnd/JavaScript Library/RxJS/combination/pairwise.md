# [pairwise](https://rxjs.dev/api/operators/pairwise)

- 將傳入的 Observable item 以二二一組做為 array 輸出

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise } from 'rxjs/operators';


const source = interval(0).pipe(take(5));

of(1,2,3,4,5)
.pipe(pairwise())
.subscribe(
  (val) => console.log(val),
  (err) => console.log(err),
  () => console.log('complete')
);
```

輸出:

```
> [1, 2]
> [2, 3]
> [3, 4]
> [4, 5]
complete
```
