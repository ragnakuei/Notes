# [defer](https://rxjs.dev/api/index/function/defer)

在 `subscribe()` 時，才會執行

### 範例

s1 會立即執行
二秒後
s2 因為 subscribe 才執行，所以慢了 2 秒

```js
import { defer, of, timer, merge } from 'rxjs';

const s1 = of('1 ' + new Date());
const s2 = defer(() => of('2 ' + new Date()));

setTimeout(() => {
  s1.subscribe(console.log);
  s2.subscribe(console.log);
}, 2000);
```
