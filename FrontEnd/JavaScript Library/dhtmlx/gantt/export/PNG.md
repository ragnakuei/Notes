# PNG

- [exportToPNG](https://docs.dhtmlx.com/gantt/api__gantt_exporttopng.html)

```js
gantt.exportToPNG( {
                       // 檔名
                       name: "gantt.png",

                       // 匯出 service url，也可以指向 local export module 的 url
                       server: "https://export.dhtmlx.com/gantt",

                       // 中文只有 cn
                       // local: "cn"

                       raw: true,

                       // data: {},

                       // 如果指定了 callback ，就不會直接下載，而是呼叫 callback
                       // callback 的參數為 圖檔 url
                       // callback: ( url ) => {
                       //     console.log( "exportImage", url );
                       // }
                   } );
```