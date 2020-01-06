# Inline ajax 範例

Inline 的設定大於 以 js 的設定

- 當給定 data-toggle="bootgrid" attribute 後，就會忽略 js 的設定了

```html
<table
  id="grid-data-api"
  class="table table-condensed table-hover table-striped"
  data-toggle="bootgrid"
  data-ajax="true"
  data-url="/api/customer"
>
  <thead>
    <tr>
      <th
        data-column-id="Id"
        data-type="numeric"
        data-identifier="true"
        data-order="asc"
      >
        ID
      </th>
      <th data-column-id="Name">Name</th>
      <th data-column-id="Tel1">Tel 1</th>
      <th data-column-id="Addr1">Address 1</th>
    </tr>
  </thead>
</table>
```
