# [debounce](https://rxjs.dev/api/operators/debounce)

- 每個 next 執行間隔小於 debounce time 才會允許執行

#### 範例

```js
import { of, range, timer } from 'rxjs';
import { debounce, mergeMap, delay, concatMap } from 'rxjs/operators';

const example = range(1,10)
.pipe(concatMap(i => of(i).pipe(delay(500))))
.pipe(debounce(() => timer(400)))
.subscribe(val => console.log('next', val),
           (err) => console.log('error', err),
           () => console.log('complete')
);
```

如果把 timer 的 400 改成 600

只會收到 next 10


#### 範例

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

const example = range(1,10)
.pipe(concatMap(i => of(i).pipe(delay( getRandomInt(1000)))))

// 當 debounce time 小於 delay 間隔時，就會允許執行當下的 next 
.pipe(debounce(() => timer(500)))
.subscribe(val => console.log('next', val),
           (err) => console.log('error', err),
           () => console.log('complete')
);
```