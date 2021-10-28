# [bufferToggle](https://rxjs.dev/api/operators/bufferToggle)

- 指定每次 buffer 抓取頻率 及 抓取時間長度，每次 buffer 都是獨立的，因此可能會抓到相同的 next !
- 參數
  - 第一個 - buffer 抓取頻率
  - 第二個 - buffer 抓取時間長度。timer / interval 效果相同，用 timer 比較不會混淆 !

#### 範例

- 每個 next 間隔 300ms，每 300ms 抓取 buffer，抓取時間長達 900ms
  - 每個 buffer 都會重複二個 next 值

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip, range } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom, zipWith, throttleTime, debounce, buffer, bufferCount, bufferTime, bufferToggle } from 'rxjs/operators';

range(1,20)
.pipe(concatMap(i => of(i).pipe(delay(300))))
.pipe(bufferToggle(
  interval(300),
  x => interval(900)
))
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```