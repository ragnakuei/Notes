# [endWith](https://rxjs.dev/api/operators/endWith)

```js
import { of, iif, interval, timer, combineLatest, concat } from 'rxjs';
import { combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith } from 'rxjs/operators';

of(1,3,4)
.pipe(take(2), endWith(2))
.subscribe(
  (val) => console.log(val),
  (err) => console.log(err),
  () => console.log('complete')
);
```