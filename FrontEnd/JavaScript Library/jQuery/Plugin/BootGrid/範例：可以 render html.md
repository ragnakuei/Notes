# 範例：可以 render html

如果有需要一次顯示巢狀的資料，必須先將資料轉成 html 再顯示

```
<table id="grid-keep-selection" class="table table-condensed table-hover table-striped">

    <thead>

        <tr>

            <th data-column-id="visitorId" data-identifier="true">visitorId</th>

            <th data-column-id="serverDatePretty">serverDatePretty</th>

        </tr>

    </thead>

</table>
```

```js
var res = [
  {
    visitorId: 1,

    serverDatePretty: "<h1>Test</h1>"
  }
];

$("#grid-keep-selection").bootgrid("append", res);
```
