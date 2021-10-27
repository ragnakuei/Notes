# [of](https://rxjs.dev/api/index/function/of)

```js
of(...values, scheduler: Scheduler): Observable
```

#### 範例

```js
import { of } from 'rxjs';
const source = of(1, 2, 3, 4, 5);
const subscribe = source.subscribe(val => console.log(val));
```
