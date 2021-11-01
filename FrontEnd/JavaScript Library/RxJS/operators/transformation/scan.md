# [scan](https://rxjs.dev/api/operators/scan)

- 會回傳每個 next 處理的結果

#### 範例

```js
import { of, range, partition } from 'rxjs';
import { mergeMap, groupBy, reduce, map, concatMap, exhaustMap, switchMap, mapTo, mergeScan, pluck, scan } from 'rxjs/operators';

range(1, 10).pipe(
  scan((acc, cur) => acc + cur, 0)
)
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```

執行結果

```
1
3
6
10
15
21
28
36
45
55
complete
```