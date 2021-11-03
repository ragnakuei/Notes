# [concatMap](https://rxjs.dev/api/operators/concatMap)

- 將 Observable\<T> 給解開成 T 給 Subscribe.Next

#### 範例

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip, range } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom, zipWith, throttleTime, debounce, buffer, bufferCount, bufferTime, bufferToggle, bufferWhen } from 'rxjs/operators';

of(of(1, 4), of(2), of(3))
.pipe(concatMap(x => x))
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```

顯示結果
```
1
4
2
3
```

#### 每個 Observable item 中間插複一個 delay

```js
of(1,2,3)
.pipe(concatMap(x => of(x).pipe(delay(500))))
.subscribe(
  (val) => console.log(val),
  (err) => console.log(err),
  () => console.log('complete')
);
```
