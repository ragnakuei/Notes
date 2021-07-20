# 解析 Date() 格式

## 解析 /Date(unixtimestamp)/

```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

<script>
  var a = moment('/Date(1626653700000)/'); 
  console.log(a.format());
</script>
```