# [interval](https://rxjs.dev/api/index/function/interval)

依照給定的時間間隔，給定流水號

```js
import { interval } from 'rxjs';

const source = interval(500);
const subscribe = source.subscribe(val => console.log(val));
```