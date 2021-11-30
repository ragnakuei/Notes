# 模擬發出多個 request，把 response 放進 array 中

```ts
range(1, 5)
    .pipe(
        map((i: number) => this.getReponse(i)),
        combineAll(),
    )
    .toPromise()

    // 如果 range 給定 1 ~ 5，則 o 為 [1,2,3,4,5]
    .then(o => console.log('o', o))

    // 如果 range 給 1 ~ 6 就會直接執行這
    .catch(err => console.log('err', err));

private getReponse(i: number): Observable<number> {
    if (i === 6) {
        throw Error(`custom error i:${ i }`);
    }

    console.log(`i:${i}`);

    return of(i);
}
```