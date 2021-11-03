# [exhaustMap](https://rxjs.dev/api/operators/exhaustMap)

- 有 concatMap 效果 + index
- 有 concatMapTo 效果 + index
- 行為
  - project
    - 要等 project 參數執行完畢，才會執行至 subscribe next
    - project 未執行完畢時，會留下 source 拋出的最後一個 next ，其餘會忽略
    - 可以想成，每累積大於 project 所指定的時間後，會 next 開始累績的 item 值


```js
exhaustMap<T, R, O extends ObservableInput<any>>(
        project: (value: T, index: number) => O, 
        resultSelector?: (
            outerValue: T, 
            innerValue: ObservedValueOf<O>, 
            outerIndex: number, 
            innerIndex: number
        ) => R
    ): OperatorFunction<T, ObservedValueOf<O> | R>
```


#### 第一個參數

- 有 concatMap 效果 + index

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip, range } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom, zipWith, throttleTime, debounce, buffer, bufferCount, bufferTime, bufferToggle, bufferWhen, concatMapTo, exhaustMap } from 'rxjs/operators';

range(1,20)
.pipe(
  exhaustMap( (v, i) => of(`value:${v} index:${i}`))
)
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```

#### 第二個參數

- 有 concatMapTo 效果 + index

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip, range } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom, zipWith, throttleTime, debounce, buffer, bufferCount, bufferTime, bufferToggle, bufferWhen, concatMapTo, exhaustMap } from 'rxjs/operators';

range(1,5)
.pipe(
  exhaustMap( 
      (v, i) => range(11, 5),
      (v1, v2, i1, i2) => `value 1:${v1} value 2:${v2} index 1:${i1} index 2:${i2}`
    )
)
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```

#### 套用 時間 範例一

- source 每 500ms 做一個 next
- 經過 project 750ms 執行完畢後
- 才會執行到 subscribe next

```js
interval(500)
.pipe(
  exhaustMap( 
      (v, i) => timer(750),
      (v1, v2, i1, i2) => `value 1:${v1} value 2:${v2} index 1:${i1} index 2:${i2}`
    )
)
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```

執行結果

- source 奇數部份，因為剛好在 project 等待階段，所以都被忽略了

```
value 1:0 value 2:0 index 1:0 index 2:0
value 1:2 value 2:0 index 1:1 index 2:0
value 1:4 value 2:0 index 1:2 index 2:0
value 1:6 value 2:0 index 1:3 index 2:0
value 1:8 value 2:0 index 1:4 index 2:0
value 1:10 value 2:0 index 1:5 index 2:0
...
```


#### 套用 時間 範例二

- 要等 project 參數執行完畢，才會執行至 subscribe next
  - project 未執行完畢時，會留下 source 拋出的最後一個 next ，其餘會忽略

```js
range(1,10)
.pipe(concatMap(x => of(x).pipe(delay(500))))
.pipe(
    exhaustMap( 
      x => timer(750) ,
      (v1, v2, i1, i2) => `value 1:${v1} value 2:${v2} index 1:${i1} index 2:${i2}`
    )
)
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```

執行結果

```
value 1:1 value 2:0 index 1:0 index 2:0
value 1:3 value 2:0 index 1:1 index 2:0
value 1:5 value 2:0 index 1:2 index 2:0
value 1:7 value 2:0 index 1:3 index 2:0
value 1:9 value 2:0 index 1:4 index 2:0
complete
```


#### 套用 時間 範例三

- 可以想成，每累積大於 project 所指定的時間後，會 next 開始累績的 item 值

```js
import { from, of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip, range } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom, zipWith, throttleTime, debounce, buffer, bufferCount, bufferTime, bufferToggle, bufferWhen, concatMapTo, exhaustMap, switchMap } from 'rxjs/operators';

function getRandomInt(max) {
  const result = Math.floor(Math.random() * max);
  console.log('random value', result);
  return result;
}

range(1,10)
.pipe(concatMap(x => of(x).pipe(delay(getRandomInt(400)))))
.pipe(
    exhaustMap( 
      x => timer(400) ,
      (v1, v2, i1, i2) => `value 1:${v1} value 2:${v2} index 1:${i1} index 2:${i2}`
    )
)
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```

執行結果

```
random value 67
random value 86
random value 359
value 1:1 value 2:0 index 1:0 index 2:0
random value 349
random value 139
value 1:3 value 2:0 index 1:1 index 2:0
random value 284
random value 353
value 1:5 value 2:0 index 1:2 index 2:0
random value 83
random value 78
random value 343
value 1:7 value 2:0 index 1:3 index 2:0
value 1:10 value 2:0 index 1:4 index 2:0
complete
```