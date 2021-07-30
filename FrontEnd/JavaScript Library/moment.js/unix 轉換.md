# unix 轉換

## unix seconds

```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

<script>
  var a = moment.unix(1627540702); 
  console.log(a.format());
  
  var b = moment('2021-07-29T14:38:22+08:00');
  console.log(b.unix());

  // 預設會帶目前 client 時區
  var c = moment('2021-07-29T14:38:22');
  console.log(c.unix());
</script>
```

moment.unix(1627540702).format() 出來的結果，可以直接套用至 input type="datetime-local" 中 !
