# [expand](https://rxjs.dev/api/operators/expand)

- 最多只會跑到 790 次
- 第二個參數：concurrent 數量
- 可用 take 做限次存取次數
- 行為
  - 第一次會先執行 next
  - 接下來把第一次的 next 放 func 中，回傳的才是第二次的 next 
- 適合用來做 recursive
  

```js
expand<T, O extends ObservableInput<unknown>>(
        project: (value: T, index: number) => O, 
        concurrent: number = Infinity, 
        scheduler?: SchedulerLike
    ): OperatorFunction<T, ObservedValueOf<O>>
```


#### 範例 2 的 N 次方

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip, range } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom, zipWith, throttleTime, debounce, buffer, bufferCount, bufferTime, bufferToggle, bufferWhen, concatMapTo, exhaustMap, expand } from 'rxjs/operators';

// range(1,20)
// .pipe(concatMap(i => of(i).pipe(delay(300))))

of(1)
.pipe(
  expand( 
      (v, i) => of(2 * v),
      1
    ),
  take(10)
)
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```