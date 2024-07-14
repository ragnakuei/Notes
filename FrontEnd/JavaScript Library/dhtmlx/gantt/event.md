# [Event](https://docs.dhtmlx.com/gantt/api__refs__gantt_events.html)

### 在 Grid Header 上點擊事件 ( 左鍵 )

```js
gantt.attachEvent('onGridHeaderClick', function (name, e) {
    console.log('onGridHeaderClick name', name);
    console.log('e', e);
    return false;
});
```

### 在 Task 上點擊事件 ( 左鍵 )

```js
gantt.attachEvent('onTaskClick', function (name, e) {
    console.log('onTaskClick name', name);
    console.log('e', e);
    return false;
});
```

### 在 Gantt 上點擊滑鼠右鍵事件

```js
gantt.attachEvent('onContextMenu', (taskId, linkId, event) => {
    console.log('onContextMenu taskId', taskId);
    console.log('onContextMenu linkId', linkId);
    console.log('onContextMenu event', event);

    const target = event.target || event.srcElement;
    console.log('target', target);
    console.log('target.dataset', target.dataset);
    const column_name = target.dataset.columnName;
    console.log('column_name', column_name);

    if (column_name) {
        // 代表是 Grid Header
    } else {
        // 代表是 Grid Header 以外的地方
    }

    return false;
});
```
