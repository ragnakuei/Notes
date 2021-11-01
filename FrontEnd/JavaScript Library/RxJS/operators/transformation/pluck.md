# [pluck](https://rxjs.dev/api/operators/pluck)

指定 {} 的 property name，來拆解 Observable\<{}>  為 Observable\<T>

#### 範例

- 等於 `map(v => v.value)` 的效果

```js
import { of, range, partition } from 'rxjs';
import { mergeMap, groupBy, reduce, map, concatMap, exhaustMap, switchMap, mapTo, mergeScan, pluck } from 'rxjs/operators';

of(
  { value : 1 },
  { value : 2 },
  { value : 3 },
).pipe(
  pluck('value')
)
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```
