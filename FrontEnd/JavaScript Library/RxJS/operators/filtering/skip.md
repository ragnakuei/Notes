# [skip](https://rxjs.dev/api/operators/skip)

- 略過指定數目的項目

```js
import { of, range, timer } from 'rxjs';
import { audit, mergeMap, delay, concatMap, auditTime, distinct, filter, find, first, ignoreElements, last, single, skip } from 'rxjs/operators';

of(1,2,3,4,5,6)
.pipe(skip(2))
.subscribe({
  next: (val) => console.log('next', val),
  complete: () => console.log('complete'),
  error: (err) => console.log('error',err),
});
```
