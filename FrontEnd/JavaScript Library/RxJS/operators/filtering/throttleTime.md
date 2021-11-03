# [throttleTime](https://rxjs.dev/api/operators/throttleTime)

- 間隔指定時間做 next
- 第三個參數為 option
  - leading - 以該間隔的第一個 item 做 next
  - tailing - 以該間隔的最後一個 item 做 next
  - 如果上述二個參數都為 true 時
    - 第一個為第一組的 leading
    - 第二個為第一組的 tailing，之後都是抓各組的 tailing
  - 可以搭配 buffer + interval 來看 leading / tailing 規則

#### throttleTime + timer 範例一

- delay 改成 500 或 500 以上，都收得到 next 訊息

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip, range } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom, zipWith, throttleTime, debounce } from 'rxjs/operators';

range(1,20)
.pipe(concatMap(i => of(i).pipe(delay(300))))
.pipe(throttleTime(1000, null, {
  leading : false,
  trailing : true,
}))
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```
