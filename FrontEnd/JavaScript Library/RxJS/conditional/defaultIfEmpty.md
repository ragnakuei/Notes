# [defaultIfEmpty](https://rxjs.dev/api/operators/defaultIfEmpty)



```js
import { defaultIfEmpty } from 'rxjs/operators';
import { of } from 'rxjs';

const source = of()
.pipe(
  defaultIfEmpty('Observable.of() Empty!')
)
.subscribe(val => console.log(val),
           err => console.log(err),
           () => console.log('complete'));
```


```js
import { defaultIfEmpty } from 'rxjs/operators';
import { empty } from 'rxjs';

const source = empty()
.pipe(
  defaultIfEmpty('Observable.of() Empty!')
)
.subscribe(val => console.log(val),
           err => console.log(err),
           () => console.log('complete'));
```