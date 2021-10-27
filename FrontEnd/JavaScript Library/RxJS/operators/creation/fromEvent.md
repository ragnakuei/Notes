# [fromEvent](https://rxjs.dev/api/index/function/fromEvent)

#### 範例

點擊 docuemnt 時，就會執行 !

```js
import { fromEvent } from 'rxjs';
import { map } from 'rxjs/operators';

const source = fromEvent(document, 'click');
const example = source.pipe(map((event) => `Event time: ${event.timeStamp}`));
const subscribe = example.subscribe((val) => console.log(val));
```