# dialog

- 關閉事件最好不要用 close event 處理，因為 按下右上角 x 關閉 dialog，不會觸發 close event，但會觸發 dialogclose event

### 註冊方式

```js
const dl = $('#detail').dialog({
    autoOpen: false,
    width: 'auto',
    modal: true,
    close: function (event, ui )
    {
        WorkServiceOrderAssignmentList.Reload();
    }
});
```

### 以程式開啟及關閉

```js
const dl = $('#detail').dialog({
                               autoOpen: false,
                               width: 'auto',
                               modal: true,
                               close: function (event, ui )
                               {
                                   WorkServiceOrderAssignmentList.Reload();
                               }
                             });
dl.dialog("open");
dl.dialog("close");
```

### 按下右上角 x 關閉的事件

- 最好所有關閉事件都用這個方式處理

```js
$('#detail').on('dialogclose', function ()
{
    
});
```

- 或是直接在初始化時，就給定 close function

```js
$('#detail').dialog({
    autoOpen: false,
    width: 'auto',
    modal: true,
    close: function (event, ui )
    {
        WorkServiceOrderAssignmentList.Reload();
    }
});
```


### 按下 Dialog 以外的地方，關閉 Dialog

```js
$('.ui-widget-overlay').on('click', function()
{
    dl.dialog("close");
});
```