# datepicker

### 設定 format 的方式

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

### 加入自訂的按鈕

加上 Clear 按鈕

- showButtonPanel 要設為 true
- beforeShow 裡面一定要用 setTimeout() 包起來

```html
<p>Date: <input type="text" id="datepicker"></p>

<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="//code.jquery.com/jquery-3.6.0.js"></script>
<script src="//code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
    $(function () {
        const datePickerInst = $("#datepicker").datepicker({
            showButtonPanel: true,
            dateFormat: "yy-mm-dd",
            // minDate: minDiffDay,
            // maxDate: maxOffsetDay,
            beforeShow: function (input, inst) {
                setTimeout(function () {
                    // 方式一
                    // const buttonPane = $(input).datepicker("widget").find(".ui-datepicker-buttonpane");
                    // console.log("buttonPane", buttonPane);

                    // 方式二
                    const buttonPane = inst.dpDiv.find(".ui-datepicker-buttonpane");
                    // console.log("buttonPane", buttonPane);

                    $("<button type='button'></button>")
                        .text("Clear")
                        .unbind("click")
                        .bind("click", function () {
                            // clear value
                            // datePickerInst.val(null);
                            datePickerInst.datepicker("setDate", null);

                            datePickerInst.datepicker("hide");
                        })
                        .appendTo(buttonPane)
                        .addClass("ui-datepicker-clear ui-state-default ui-priority-primary ui-corner-all");
                    
                }, 1);
            }
        });
    });
</script>
```