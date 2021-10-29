# [mergeMap](https://rxjs.dev/api/operators/mergeMap) / [flatMap](https://rxjs.dev/api/operators/flatMap)

- flatMap 在 v8 時，會 rename 成 mergeMap
- 跟 exhaustMap 類似

```js
mergeMap<T, R, O extends ObservableInput<any>>(
    project: (value: T, index: number) => O, 
    resultSelector?: number | ((outerValue: T, 
                                innerValue: ObservedValueOf<O>, 
                                outerIndex: number, 
                                innerIndex: number) => R), 
    concurrent: number = Infinity
): OperatorFunction<T, ObservedValueOf<O> | R>
```


#### 


```js

