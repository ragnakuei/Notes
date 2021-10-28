# [single](https://rxjs.dev/api/operators/single)

- 如果有二筆以上的資料，會輸出 exception
  - 可以透過 subscribe error 來處理後續

```js
import { of, range, timer } from 'rxjs';
import { audit, mergeMap, delay, concatMap, auditTime, distinct, filter, find, first, ignoreElements, last, single } from 'rxjs/operators';

of(1)
.pipe(single())
.subscribe({
  next: (val) => console.log('next', val),
  complete: () => console.log('complete'),
  error: (err) => console.log('error',err),
});
```