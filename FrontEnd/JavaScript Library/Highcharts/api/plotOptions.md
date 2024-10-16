# [plotOptions](https://api.highcharts.com/highcharts/plotOptions)

```js
plotOptions: {
    pie: {
        shadow: false,
        center: ['50%', '50%'],
        dataLabels: {
            // enabled: false
        },
        states: {
            inactive: {
                opacity: 1 // This disables the dimming effect
            }
        }
    }
},
```

### pie

設定此 highchart 為 pie chart 時的相關設定。

### shadow

設定是否要顯示陰影。

### center

設定圓餅圖的中心位置。

### dataLabels

設定是否要顯示 tooltip。

### states

設定圖表的狀態。

#### inactive

當 hover 至 highchart 時，設定非 active 的透明度。

0 - 完全不透明
1 - 完全透明，無透明效果