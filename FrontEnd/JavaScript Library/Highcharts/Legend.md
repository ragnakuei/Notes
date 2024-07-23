# [Legend](https://www.highcharts.com/docs/chart-concepts/legend)

[API Reference](https://www.highcharts.com/docs/chart-concepts/legend)

demo 範例

```js
Highcharts.chart('charts', {
    accessibility: {
        // 移除警告訊息
        enabled: false,
    },
    chart: {
        type: 'column',
        backgroundColor: 'transparent',
    },
    title: {
        text: '',
    },
    xAxis: {
        type: 'category',
        labels: {
            style: {
                fontSize: '13px',
                fontFamily: 'Verdana, sans-serif',
            },
        },
        categories: xAxisCategories,
    },
    yAxis: {
        title: {
            text: '百萬',
        },
    },
    legend: {
        // align: 'center',
        // x: 10,
        // verticalAlign: 'top',
        // y: -10,
        // floating: true,
        enabled: true,
    },
    plotOptions: {
        column: {
            stacking: 'normal',
            dataLabels: {
                enabled: true,
            },
        },
    },

    series: [
        {
            name: '金額',
            data: [
                {
                    2020: 100,
                    2021: 200,
                    2022: 300,
                },
            ],
        },
    ],
});
```

位置順序： `floating` -> `align` -> `x` -> `verticalAlign` -> `y`
原點在左上角

預設值
```json
{
    floating: false,
    align: 'center',
    x: 0,
    verticalAlign: 'bottom',
    y: 0,
    borderColor: '#CCC',
    borderWidth: 0,
    layout: 'horizontal',
    enabled: true,
}
```


```json

    "floating": true,       // true 會讓 legend 嵌在 chart 內，false 會讓 legend 在 chart 外
    "align": "center",      // x 軸對齊方式
    "x": 0,                 // x 軸位置
    "verticalAlign": "top", // y 軸對齊方式
    "y": 0,                 // y 軸位置

    "borderColor": "#CCC",  // 邊框顏色
    "borderWidth": 1,       // 邊框寬度

    "layout": "horizontal", // 水平或垂直擴展
    "enabled": true
}
```
