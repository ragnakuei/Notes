# [tooltip](https://api.highcharts.com/highcharts/tooltip)

```js
tooltip: {
    // valueSuffix: '%',
    hideDelay: 0,  // 切換 tooltip 時不要有延遲
    formatter: function() {

        if(this.point.content) {
            return '<b>' + this.point.content + '</b>';
        } 

        return false;
    }
},
```

### valueSuffix

讓 tooltip 的數值後面加上字串，例如 `%`。

### hideDelay

設定 tooltip 消失的延遲時間，單位是毫秒。

如果從 有顯示 tooltip 移至 return false 的區塊上時，會因為這個延遲的設定，導致不會立即消失。


### formatter

設定 tooltip 顯示的內容。

this.point 是指當前的點，可以取得該點的資料。

如果不要顯示 tooltip，要回傳 false。