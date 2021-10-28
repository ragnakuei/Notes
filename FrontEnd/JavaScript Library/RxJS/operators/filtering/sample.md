# [sample](https://rxjs.dev/api/operators/sample)

- 取樣的意思
- 取樣時間差如果小於來源時，就會以來源間隔為主

```js
import { of, range, timer, interval } from 'rxjs';
import { audit, mergeMap, delay, concatMap, auditTime, distinct, filter, find, first, ignoreElements, last, sample } from 'rxjs/operators';

interval(1000)
.pipe(sample(interval(2000)))
.subscribe({
  next: (val) => console.log('next', val),
  complete: () => console.log('complete'),
  error: (err) => console.log('error',err),
});
```