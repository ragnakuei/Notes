# datepicker

- 設定 format 的方式

```js
$( "#datepicker" ).datepicker({ dateFormat : "yy/mm/dd" });
```

- 選定日期後，要額外做處理

```js
$( "#datepicker" ).datepicker({ 
    dateFormat : "yy/mm/dd" ,
    onSelect: function (dateText, inst) {
        selectDate.value = dateText;
    }
});
```