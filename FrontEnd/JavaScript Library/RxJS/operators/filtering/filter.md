# [filter](https://rxjs.dev/api/operators/filter)


```js
import { of, range, timer } from 'rxjs';
import { audit, mergeMap, delay, concatMap, auditTime, distinct, filter } from 'rxjs/operators';

of(1, 2, 3, 4, 5)
.pipe(filter(v => v%2 === 0))
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```