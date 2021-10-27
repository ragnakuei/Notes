# [empty](https://rxjs.dev/api/index/function/empty)

- next 不會被觸發，直接觸發 complete !
- v8 之後會被改為 EMPTY

```js
import { empty } from 'rxjs';

const subscribe = empty().subscribe({
  next: () => console.log('Next'),
  complete: () => console.log('Complete!')
});
```