# [distinctUntilKeyChanged](https://rxjs.dev/api/operators/distinctUntilKeyChanged)

- 針對物件的 property 做判斷
- 不連續重複輸出 next

```js
import { from, of, range, timer } from 'rxjs';
import { audit, mergeMap, delay, concatMap, auditTime, distinct, distinctUntilChanged, distinctUntilKeyChanged } from 'rxjs/operators';

from([
  { name: 'Brian' },
  { name: 'Joe' },
  { name: 'Joe' },
  { name: 'Sue' }
])
.pipe(distinctUntilKeyChanged('name'))
.subscribe({
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
});
```