# [debounceTime](https://rxjs.dev/api/operators/debounceTime)

- 等於 debounce(() => timer(N)) 的語法
- 會先額外執行一次 empty

#### 範例

- 給定 1 ~ 10 ，間隔隨機 0~999 ms 
- debounce time 固定 500ms
- 只要大於 debounce time 的 delay 都會執行 next

```js
import { of, range, timer } from 'rxjs';
import { debounce, mergeMap, delay, concatMap, debounceTime } from 'rxjs/operators';

function getRandomInt(max) {
    const result = Math.floor(Math.random() * max);
    console.log('random value', result);
    return result;
  }

range(1,10)
.pipe(concatMap(i => of(i).pipe(delay( getRandomInt(1000)))))

// 當 debounce time 小於 delay 間隔時，就會允許執行當下的 next 
.pipe(debounceTime(500))
.subscribe(val => console.log('next', val),
           (err) => console.log('error', err),
           () => console.log('complete')
);
```

