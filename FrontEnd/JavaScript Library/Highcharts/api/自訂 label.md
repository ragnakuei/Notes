# 自訂 Label


```js
const chart = Highcharts.chart( 'container', {
    chart: {
        type: 'column'
    },
    title: {
        text: '自訂標籤'
    },
    series: [ {
        data: [ 1, 2, 3, 4, 5 ]
    } ]
} );

chart.renderer.text( '自定義標籤', 275, 110 ) // x, y 位置
        .css( {
                color:      '#000000',
                fontSize:   '14px',
                fontFamily: 'Verdana,微軟正黑體, Microsoft JhengHei, Arial, Helvetica, sans-serif',
                fontWeight: 700,
            } )
        .attr( {
                zIndex: 99999 // 設置 zIndex 確保在最上方
            } )
        .add();
```
