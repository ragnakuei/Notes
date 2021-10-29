# [groupBy](https://rxjs.dev/api/operators/groupBy)


```js
groupBy<T, K, R>(keySelector: (value: T) => K, 
        elementOrOptions?: void | ((value: any) => any) | BasicGroupByOptions<K, T> | GroupByOptionsWithElement<K, R, T>, 
        duration?: (grouped: GroupedObservable<any, any>) => ObservableInput<any>, 
        connector?: () => SubjectLike<any>
    ): OperatorFunction<T, GroupedObservable<K, R>>
```

