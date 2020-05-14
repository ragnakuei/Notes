# 範例：透過 jQuery ajax 取得資料，以 array 的方式給定資料

1. 以 jQuery ajax 取得資料 (用意：打破 CORS 的限制)

1. 以 array 的方式，放進 BootGrid 中

1. 將完整資料取回來再做分頁

```html
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type" />

    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
      type="text/css"
    />

    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/jquery-bootgrid/1.3.1/jquery.bootgrid.css"
      type="text/css"
    />

    <script
      type="text/javascript"
      src="https://code.jquery.com/jquery-1.11.1.min.js"
    ></script>

    <script
      type="text/javascript"
      src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"
    ></script>

    <script
      type="text/javascript"
      src="https://cdnjs.cloudflare.com/ajax/libs/jquery-bootgrid/1.3.1/jquery.bootgrid.min.js"
    ></script>
  </head>

  <body>
    <h2>Visitors&nbsp;Log</h2>

    <div id="dataTable">
      <table
        id="grid-keep-selection"
        class="table table-condensed table-hover table-striped"
      >
        <thead>
          <tr>
            <th data-column-id="visitorId" data-identifier="true">visitorId</th>
            <th data-column-id="serverDatePretty">serverDatePretty</th>
            <th data-column-id="serverTimePretty">serverTimePretty</th>
            <th data-column-id="referrerTypeName">referrerTypeName</th>
            <th data-column-id="visitIp">visitIp</th>
            <th data-column-id="country">country</th>
            <th data-column-id="region">region</th>
            <th data-column-id="city">city</th>
            <th data-column-id="browser">browser</th>
            <th data-column-id="operatingSystem">operatingSystem</th>
            <th data-column-id="deviceType">deviceType</th>
            <th data-column-id="Actions">Actions</th>
          </tr>
        </thead>
      </table>
    </div>

    <script>
      var token = "c36456595fe8fd19ff399f8e422a094b";
      var apiMethod = "Live.getLastVisitsDetails";
      var idSite = 93;
      var queryDate = "2018-03-09";
      var queryPeriod = "day";
      var insertDataId = "dataTable";

      GetData();

      function GetData() {
        try {
          $.ajax({
            type: "Get",

            // dataType、headers 的設定是為了打破 CORS 的限制
            dataType: "jsonp",

            headers: {
              "Access-Control-Allow-Origin": "*"
            },

            url:
              "https://asiannet.innocraft.cloud/?module=API&token_auth=" +
              token +
              "&method=" +
              apiMethod +
              "&format=json&idSite=" +
              idSite +
              "&period=" +
              queryPeriod +
              "&date=" +
              queryDate,

            contentType: "application/json",
            async: "true",
            statusCode: {
              200: function(res) {
                $("#grid-keep-selection").bootgrid("append", res);
              }
            }
          });
        } catch (e) {
          console.log("error occurs");
          console.log(e);
        }
      }
    </script>
  </body>
</html>
```
