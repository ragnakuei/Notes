# [generate](https://rxjs.dev/api/index/function/generate)

```js
generate<T, S>(initialStateOrOptions: S | GenerateOptions<T, S>, 
               condition?: ConditionFunc<S>, iterate?: IterateFunc<S>, 
               resultSelectorOrScheduler?: SchedulerLike | ResultFunc<S, T>, 
               scheduler?: SchedulerLike): Observable<T>
```
#### 範例


```js
import { generate } from 'rxjs';

generate(
  2,
  x => x <= 10,
  x => x + 3
).subscribe(console.log);
```