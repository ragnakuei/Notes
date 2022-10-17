# dynamic order by

```js
// toggle 指定欄位的排序 asc / desc
function global_toggle_sort(sort_column_map, column) {
    const sort_column_map_order = sort_column_map[column];
    if (sort_column_map_order) {
        if (sort_column_map_order === 'asc') {
            sort_column_map[column] = 'desc';
        } else {
            sort_column_map[column] = 'asc';
        }
    } else {
        sort_column_map[column] = 'asc';
    }

    // 清除其他欄位排序
    for (let key in sort_column_map) {
        if (key !== column) {
            sort_column_map[key] = '';
        }
    }

    return sort_column_map;
}

// 依照指定的欄位排序
Array.prototype.global_sort = function( column, order ) {
    
    if(this?.length > 0 === false) {
        return this;
    }
    
    if( order === 'asc' ) {
        return this.sort( function( a, b ) {
            // if value is string
            if( isNaN( a[column] ) ) {
                return a[column] > b[column] ? 1 : -1;
            } 
            
            // if value is Number
            return a[column] - b[column];
        } );
    } else {
        return this.sort( function( a, b ) {
            // if value is string
            if( isNaN( a[column] ) ) {
                return b[column] > a[column] ? 1 : -1;
            } 
            
            // if value is String
            return b[column] - a[column];
        } );
    }
    
}
```

### 搭配 icon vue component

```html
<script>
    window.vue_icon = {
        template: `
<template v-if="type === 'sort'">
  <template v-if="sort_option === 'asc'">
    <i class="fa fa-triangle fa-sm"></i>
  </template>
  <template v-if="sort_option === 'desc'">
    <i class="fa fa-triangle fa-sm fa-rotate-180"></i>
  </template>
</template>

<template v-if="type === 'checkbox'">
  <template v-if="checkbox_option">
    <i class="fas fa-check-square fa-2x"></i>
  </template>
  <template v-if="!checkbox_option">
    <i class="far fa-square fa-2x"></i>
  </template>
</template>
`,
        props: {
            // sort / checkbox
            type: String,

            // sort => asc / desc
            sort_option: String,

            // checkbox => true / false
            checkbox_option: Boolean,
        },
        setup(props, { emit }) {
            return {};
        },
    };
</script>
```

### 使用方式

```html
<th>
    <a href="javascript:;" v-on:click="toggle_sort('columnA')">
        columnA
        <vue_icon
            type="sort"
            v-bind:sort_option="sort_column_map.columnA"
        ></vue_icon>
    </a>
</th>
<th>
    <a href="javascript:;" v-on:click="toggle_sort('columnB')">
        columnB
        <vue_icon
            type="sort"
            v-bind:sort_option="sort_column_map.columnB"
        ></vue_icon>
    </a>
</th>
<th>
    <a href="javascript:;" v-on:click="toggle_sort('columnc')">
        columnc
        <vue_icon
            type="sort"
            v-bind:sort_option="sort_column_map.columnc"
        ></vue_icon>
    </a>
</th>
```

```js
// 要排序的 array
const array = ref([]);

// 目前排序狀況
const sort_column_map = ref({
    columnA: '',
    columnB: '',
    columnC: '',
});

function toggle_sort(column) {
    sort_column_map.value = global_toggle_sort(sort_column_map.value, column);
    array.value.global_sort(column, sort_column_map.value[column]);
}
```
