# [distinctUntilChanged](https://rxjs.dev/api/operators/distinctUntilChanged)

  不連續重複輸出 next

```js
import { of, range, timer } from 'rxjs';
import { audit, mergeMap, delay, concatMap, auditTime, distinct, distinctUntilChanged } from 'rxjs/operators';

of(1, 1, 2, 3, 4, 4, 5, 1)
.pipe(distinctUntilChanged())
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```