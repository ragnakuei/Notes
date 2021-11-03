# [reduce](https://rxjs.dev/api/operators/reduce)

- 只會回傳整個 Observable\<T> 處理完的結果

```js
reduce<V, A>(
    accumulator: (acc: V | A, value: V, index: number) => A, 
    seed?: any
): OperatorFunction<V, V | A>
```

#### 第一個參數  1 至 10 的加總

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip, range } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom, zipWith, throttleTime, debounce, buffer, bufferCount, bufferTime, bufferToggle, bufferWhen, concatMapTo, exhaustMap, expand, groupBy, reduce } from 'rxjs/operators';

range(1,10)
.pipe(
  reduce((acc, v, i) => acc + v )
)
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```

執行結果

```
55
complete
```

#### 第二個參數  1 至 10 的加總 + 給定初始值

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip, range } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom, zipWith, throttleTime, debounce, buffer, bufferCount, bufferTime, bufferToggle, bufferWhen, concatMapTo, exhaustMap, expand, groupBy, reduce } from 'rxjs/operators';

range(1,10)
.pipe(
  reduce((acc, v, i) => acc + v )
)
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```