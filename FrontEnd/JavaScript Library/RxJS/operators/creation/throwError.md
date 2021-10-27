# [throwError](https://rxjs.dev/api/index/function/throwError)

```js
import { throwError } from 'rxjs';

const source = throwError('This is an error!');
const subscribe = source.subscribe({
  next: val => console.log(val),
  complete: () => console.log('Complete!'),
  error: val => console.log(`Error: ${val}`)
});
```
