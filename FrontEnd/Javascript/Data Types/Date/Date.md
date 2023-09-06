# Date



取得目前時間

```js
new Date()
```

取得目前時間的 tick

```js
new Date().getTime()
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


#### JSON.stringfy() 的影響

```js
JSON.stringify(new Date('2021/12/11 21:22:10'))
```

會得到

```
"2021-12-11T13:22:10.000Z"
```

簡單說，會直接轉成 UTC+0 且 字尾加上 `Z`

影響範圍：包含所有 library 在發出 request 時，幾乎都會用 JSON.stringfy() 來將 object 轉成 json string !


解決方式：

```js
String.prototype.fillLeft = function(fill, digits) {
    const fillString = fill.repeat(digits);
    let result = fillString + this;
    return result.slice(result.length - digits);
}

Date.prototype.toJSON = function() { 

    const year = this.getFullYear();
    const month = (this.getMonth() + 1).toString().fillLeft('0', 2);
    const day = this.getDate().toString().fillLeft('0', 2);

    const hour = this.getHours().toString().fillLeft('0', 2);
    const minutes = this.getMinutes().toString().fillLeft('0', 2);
    const seconds = this.getSeconds().toString().fillLeft('0', 2);
    const milliseconds = this.getMilliseconds().toString().fillLeft('0', 3);

    const timeZoneOffSet = this.getTimezoneOffset();
    let timeZoneOffSetByHour = '';
    let timeZoneOffSetByHourStrTemp = (timeZoneOffSet / 60).toString();

    if(timeZoneOffSet < 0) {
        timeZoneOffSetByHour = '+'
        timeZoneOffSetByHourStrTemp = -timeZoneOffSetByHourStrTemp;
    } else {
        timeZoneOffSetByHour = '-'
    }

    timeZoneOffSetByHourStrTemp = '00' + timeZoneOffSetByHourStrTemp;
    timeZoneOffSetByHourStrTemp = timeZoneOffSetByHourStrTemp.fillLeft('0', 2);
    timeZoneOffSetByHour = timeZoneOffSetByHour + timeZoneOffSetByHourStrTemp;

    const timeZoneOffSetByHourStr = timeZoneOffSetByHour

    return `${year}-${month}-${day}T${hour}:${minutes}:${seconds}.${milliseconds}${timeZoneOffSetByHour}:00`;
};
```

```js
console.log(JSON.stringify(new Date('2012/01/02 03:04:05.678')));
```

> '2012-01-02T03:04:05.678+08:00'


