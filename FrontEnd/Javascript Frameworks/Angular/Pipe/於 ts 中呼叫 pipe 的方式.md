# 於 ts 中呼叫 pipe 的方式

#### 範例一

- [DatePipe](https://angular.io/api/common/DatePipe)

```ts
format(date: Date | string, format: string, locale : string = 'en-US'): string {
    const datePipe = new DatePipe(locale);
    return datePipe.transform(date, format) || '';
}
```

假設 format 為 **yyyy/MM/dd** ，則與下面功能一致

```html
<p>The time is {{today | date:'yyyy/MM/dd'}}</p>
```