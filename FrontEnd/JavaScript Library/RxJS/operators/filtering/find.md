# [find](https://rxjs.dev/api/operators/find)

- 找出第一個符合的
- 找不到，會輸出 undefined

```js
import { of, range, timer } from 'rxjs';
import { audit, mergeMap, delay, concatMap, auditTime, distinct, filter, find } from 'rxjs/operators';

of(1, 2, 3, 4, 5)
.pipe(find(v => v%2 === 0))
.subscribe({
  next: (val) => console.log('next', val),
  complete: () => console.log('complete'),
  error: (err) => console.log('error',err),
});
```