# [concatMapTo](https://rxjs.dev/api/operators/concatMapTo)

- 有 cross join 的效果
- 行為判斷
  - 第一個參數
    - 第一個參數必須執行完畢後，才會執行 source 下一個 next
    - 原則上不適合搭配 interval，因為 interval 沒有執行完畢的動作
    - 可以搭配 timer 做固定間隔輸出
  - 第二個參數
    - 如果不給定，會以第一個參數的 next 做為整個 next 的輸出


#### cross join 效果

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip, range } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom, zipWith, throttleTime, debounce, buffer, bufferCount, bufferTime, bufferToggle, bufferWhen, concatMapTo } from 'rxjs/operators';

of(1,2,3)
.pipe(
  concatMapTo(
    of(4,5,6),
    (left, right) => `left:${left} right:${right}`
  )
)
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```

#### 每個 next 間隔 300ms

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip, range } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom, zipWith, throttleTime, debounce, buffer, bufferCount, bufferTime, bufferToggle, bufferWhen, concatMapTo } from 'rxjs/operators';

// range(1,20)
// .pipe(concatMap(i => of(i).pipe(delay(300))))

// 以上方註解二行的效果相同
range(1,20)
.pipe(
  concatMapTo(
    timer(300),
    (left, right) => left
  )
)
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```