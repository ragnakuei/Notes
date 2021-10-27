# [from](https://rxjs.dev/api/index/function/from)

可以接多種資料型態

- array
- promise
- collection
- string


#### 範例

```js
import { from } from 'rxjs';

const arraySource = from([1, 2, 3, 4, 5])
                    .subscribe(val => console.log(val));


const promiseSource = from(new Promise(resolve => resolve('Hello World!')))
                      .subscribe(val => console.log(val));

const map = new Map();
map.set(1, 'Hi');
map.set(2, 'Bye');
const mapSource = from(map)
                  .subscribe(val => console.log(val));

const source = from('Hello World')
               .subscribe(val => console.log(val));
```
