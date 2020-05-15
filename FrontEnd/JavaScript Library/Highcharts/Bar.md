# Bar

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title></title>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script>
      document.addEventListener("DOMContentLoaded", function() {
        var myChart = Highcharts.chart("container", {
          chart: {
            type: "bar"
          },
          title: {
            text: "Fruit Consumption"
          },
          xAxis: {
            categories: ["Apples", "Bananas", "Oranges"]
          },
          yAxis: {
            title: {
              text: "Fruit eaten"
            }
          },
          series: [
            {
              name: "Jane",
              data: [1, 0, 4]
            },
            {
              name: "John",
              data: [5, 7, 3]
            }
          ]
        });
      });
    </script>
  </head>
  <body>
    <div id="container" style="width:100%; height:400px;"></div>
  </body>
</html>

```
