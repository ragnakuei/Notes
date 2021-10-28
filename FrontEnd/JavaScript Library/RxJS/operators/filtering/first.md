# [first](https://rxjs.dev/api/operators/first)

- 找出第一個符合的
- 找不到，會輸出 exception
  - 可以透過 subscribe error 來處理後續

```js
import { of, range, timer } from 'rxjs';
import { audit, mergeMap, delay, concatMap, auditTime, distinct, filter, first } from 'rxjs/operators';

of(1, 2, 3, 4, 5)
.pipe(first(v => v%2 === 0))
.subscribe({
  next: (val) => console.log('next', val),
  complete: () => console.log('complete'),
  error: (err) => console.log('error',err),
});
```