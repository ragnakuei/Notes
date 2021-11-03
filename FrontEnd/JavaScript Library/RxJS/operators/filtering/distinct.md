# [distinct](https://rxjs.dev/api/operators/distinct)

- 去重複做 next

```js
import { of, range, timer } from 'rxjs';
import { audit, mergeMap, delay, concatMap, auditTime, distinct } from 'rxjs/operators';

of(1, 2, 3, 4, 5, 1, 2, 3, 4, 5)
.pipe(distinct())
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```