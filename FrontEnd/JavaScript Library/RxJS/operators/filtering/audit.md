# [audit](https://rxjs.dev/api/operators/audit)

- 每個 next 執行間隔大於/等於 audit time 才會允許執行

#### audit + timer 範例一

- delay 改成 500 或 500 以上，都收得到 next 訊息

```js
import { of, iif, interval, timer, combineLatest, concat, forkJoin, merge, race, zip, range } from 'rxjs';
import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith, concatMap, mergeAll, pairwise, mapTo, raceWith, withLatestFrom, zipWith, audit, debounce } from 'rxjs/operators';

range(1,10)
.pipe(concatMap(i => of(i).pipe(delay(600))))
.pipe(audit(() => timer(500)))
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```

#### audit + timer 範例二

```js
import { of, range, timer } from 'rxjs';
import { debounce, mergeMap, delay, concatMap, audit } from 'rxjs/operators';

function getRandomInt(max) {
    const result = Math.floor(Math.random() * max);
    console.log('random value', result);
    return result;
  }

range(1,10)
.pipe(concatMap(i => of(i).pipe(delay( getRandomInt(1000)))))

// 當 audit time 小於等於 delay 間隔時，就會允許執行當下的 next 
.pipe(audit(() => timer(500)))
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```