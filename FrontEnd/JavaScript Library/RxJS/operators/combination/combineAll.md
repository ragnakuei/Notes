# [combineAll](https://rxjs.dev/api/operators/combineAll)

> 可以結合多個 Observable\<T> 為 T[]
> v8 之後移除，改為 `combineLatestAll`

```js
import { combineAll, map, mergeMap, sequenceEqual, take } from 'rxjs/operators';
import { of, iif, interval } from 'rxjs';

const o1 = interval(500).pipe(take(2));
const o2 = o1.pipe(
  map(ev =>
    interval(100).pipe(take(5))
  ),
  take(2)
);

o2.pipe(combineAll())
  .subscribe(
    (val) => console.log(val),
    (err) => console.log(err),
    () => console.log('complete')
  );
```