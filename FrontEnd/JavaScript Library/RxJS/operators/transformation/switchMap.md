# [switchMap](https://rxjs.dev/api/operators/switchMap)

- 如果 source 每個 item 執行間隔 大於(等於?) project 執行時間，就會 next item
  - 最後一個 source item 一定會執行 next
  - 等於的情境
    - 如果用 range + delay，等於可以 next 每個 item 
    - 如果用 interval，等於則無法 next 每個 item 

```js
switchMap<T, R, O extends ObservableInput<any>>(
    project: (value: T, index: number) => O, 
    resultSelector?: (outerValue: T, 
                      innerValue: ObservedValueOf<O>, 
                      outerIndex: number, 
                      innerIndex: number) => R
): OperatorFunction<T, ObservedValueOf<O> | R>
```

#### 第一個參數

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip, range } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom, zipWith, throttleTime, debounce, buffer, bufferCount, bufferTime, bufferToggle, bufferWhen, concatMapTo, switchMap } from 'rxjs/operators';

range(1,20)
.pipe(
  switchMap( (v, i) => of(`value:${v} index:${i}`))
)
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```

#### 第二個參數

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip, range } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom, zipWith, throttleTime, debounce, buffer, bufferCount, bufferTime, bufferToggle, bufferWhen, concatMapTo, switchMap } from 'rxjs/operators';

range(1,5)
.pipe(
  switchMap( 
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

```js
import { from, of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip, range } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom, zipWith, throttleTime, debounce, buffer, bufferCount, bufferTime, bufferToggle, bufferWhen, concatMapTo, exhaustMap, switchMap } from 'rxjs/operators';

range(1,10)
.pipe(concatMap(x => of(x).pipe(delay(500))))
.pipe(
    switchMap( 
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

#### 套用 時間 範例二

- 隨機等待超過 prject 指定的 400ms 後，才會 next 當下的 item

```js
import { from, of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip, range } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom, zipWith, throttleTime, debounce, buffer, bufferCount, bufferTime, bufferToggle, bufferWhen, concatMapTo, exhaustMap, switchMap } from 'rxjs/operators';

function getRandomInt(max) {
  const result = Math.floor(Math.random() * max);
  console.log('random value', result);
  return result;
}

range(1,10)
.pipe(concatMap(x => of(x).pipe(delay(getRandomInt(1000)))))
.pipe(
    switchMap( 
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
random value 714
random value 76
random value 727
value 1:2 value 2:0 index 1:1 index 2:0
random value 408
value 1:3 value 2:0 index 1:2 index 2:0
random value 765
value 1:4 value 2:0 index 1:3 index 2:0
random value 73
random value 122
random value 23
random value 631
value 1:8 value 2:0 index 1:7 index 2:0
random value 501
value 1:9 value 2:0 index 1:8 index 2:0
value 1:10 value 2:0 index 1:9 index 2:0
complete
```