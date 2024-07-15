# [config](https://docs.dhtmlx.com/gantt/api__refs__gantt_props.html)

其實就是 Gantt API 的 Properties !

開啟拖拉

```js
gantt.config.order_branch = true;
gantt.config.order_branch_free = true;
```

開啟多選

```js
gantt.config.multiselect = true;
gantt.templates.task_class =
    gantt.templates.grid_row_class =
    gantt.templates.task_row_class =
        function (start, end, task) {
            if (gantt.isSelectedTask(task.id)) return 'gantt_selected';
        };
```

唯讀
gantt.config.readonly = true;

[gantt.config.autosize](https://docs.dhtmlx.com/gantt/api__gantt_autosize_config.html) - 指定要自動調整的維度，例：x, y, xy。不指定則不自動調整，會以 scroll bar 顯示。

[gantt.config.scale_height](https://docs.dhtmlx.com/gantt/api__gantt_scale_height_config.html) - 指定時間軸的高度

允許拖拉 task / link / milestone
gantt.config.drag_move = true;

允許調整時間長短
gantt.config.drag_resize = true;

禁用 dbclick
gantt.config.details_on_dblclick = false;

禁用拖拉 progress
gantt.config.drag_progress = false;

不使用 link
gantt.config.drag_links = false;

不拖拉多個項目
gantt.config.drag_multiple = false;

不使用多選        
gantt.config.multiselect = false;


## [gantt.parse](https://docs.dhtmlx.com/gantt/api__gantt_parse.html)

-   data - 各 project, task, milestone 的資料
-   links - 各 data item 之間的 關聯線

## [scales](https://docs.dhtmlx.com/gantt/desktop__scales.html)

用來指定 time scale 的設定。

## [types](https://docs.dhtmlx.com/gantt/desktop__task_types.html)

gantt.config.types.project

-   底色：綠

gantt.config.types.task

-   底色：青藍色

gantt.config.types.milestone

-   底色：桃紅

gannt.config.types.placeholder

-   會在最末端顯示一個灰白的 task，方便快速新增 task

### 自訂 type

```js
// 自訂 type 的宣告
gantt.config.types['customType'] = 'type_id';

// 宣告該 type 上的 label
gantt.locale.labels['type_' + 'customType'] = 'New Type';

// 宣告該 type 編輯視窗上的欄位
gantt.config.lightbox['customType' + '_sections'] = [
    {
        name: 'description',
        height: 70,
        map_to: 'text',
        type: 'textarea',
        focus: true,
    },
    {
        name: 'type',
        type: 'typeselect',
        map_to: 'type',
    },
];
```

### [columns](https://docs.dhtmlx.com/gantt/api__gantt_columns_config.html)

-   連結內有各 column 的 property 定義

### 日期格式相關

```js
//時間軸單位預設為「月」
gantt.config.scale_unit = 'month';
gantt.config.date_scale = '%Y/%m';

const _dateFormat = '%Y/%m/%d';
gantt.config.task_date = _dateFormat;
gantt.config.date_format = _dateFormat;
gantt.config.parse_date = _dateFormat;
```
