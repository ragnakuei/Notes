# [combineLatestAll](https://rxjs.dev/api/operators/combineLatestAll)

- 多個 Observable 整合
- 其中一個 Observable next 後，會抓取其他的 Observable 當下最後的一個 next 值
- 輸出成 Array

```js
import { combineAll, map, mergeMap, sequenceEqual, take } from 'rxjs/operators';
import { of, iif, interval, timer, combineLatest } from 'rxjs';


combineLatest(
  timer(0, 100).pipe(take(3)),
  timer(0, 200).pipe(take(5))
)
.subscribe(
  (val) => console.log(val),
  (err) => console.log(err),
  () => console.log('complete')
);
```

