# [debounce](https://rxjs.dev/api/operators/debounce)

- 每個 next 執行間隔大於(沒有等於) debounce time 才會允許執行
- 會先額外執行一次 empty

#### debounce + timer 範例一

- 以下不會收到任何 next

```js
import { of, range, timer } from 'rxjs';
import { debounce, mergeMap, delay, concatMap } from 'rxjs/operators';

range(1,10)
.pipe(concatMap(i => of(i).pipe(delay(400))))
.pipe(debounce(() => timer(500)))
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```

- 如果把 delay 的 400 改成 600
- 就會會收到各種 next 值

#### debounce + timer 範例二

- 給定 1 ~ 10 ，間隔隨機 0~999 ms 
- debounce time 固定 500ms
- 只要大於 debounce time 的 delay 都會執行 next

```js
import { of, range, timer } from 'rxjs';
import { debounce, mergeMap, delay, concatMap } from 'rxjs/operators';

function getRandomInt(max) {
    const result = Math.floor(Math.random() * max);
    console.log('random value', result);
    return result;
  }

range(1,10)
.pipe(concatMap(i => of(i).pipe(delay( getRandomInt(1000)))))

// 當 debounce time 小於 delay 間隔時，就會允許執行當下的 next 
.pipe(debounce(() => timer(500)))
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```