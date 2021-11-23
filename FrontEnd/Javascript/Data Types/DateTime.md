# DateTime

#### 取得目前時間

```js
new Date()
```

#### 取得該日期的該月第一天

```js
Date.prototype.firstDayOfMonth = function() {
    const firstDayOfMonthString = this.getFullYear() +'/'+ (this.getMonth() + 1) +'/'+ 1;
    const result = new Date(firstDayOfMonthString);
    return result;
}
```

#### 取得該日期的該月最後一天

- 注意：時間不是 **00:00:000** 或 **23:59:999**

```js
Date.prototype.lastDayOfMonth = function() {
    const firstDayOfMonth = this.firstDayOfMonth();
    const firstDayOfNextMonth = firstDayOfMonth.addMonths(1);
    const result = firstDayOfNextMonth.addDays(-1);
    return result;
}
```

#### 最得該日期的該月最後 tick

```js
Date.prototype.lastTickOfMonth = function() {
    const firstDayOfMonth = this.firstDayOfMonth();
    const firstDayOfNextMonth = firstDayOfMonth.addMonths(1);
    const result = new Date(firstDayOfNextMonth.getTime()-1);
    return result;
}
```

#### 加上幾日

```js
Date.prototype.addDays = function(days) {
    this.setDate(this.getDate() + days);
    return date;
}
```

#### 加上幾月

```js
Date.prototype.addMonths = function(months) {
    this.setMonth(this.getMonth() + months);
    return date;
}
```
