# 範例 04 - Table 欄位排序 & jQuery UI SelectMenu

- 如果 Option API data() 內的資料，在初始化後，不會變更的話，可以不需要用 ref、reactive
- 如果 Option API data() 內的資料，在初始化後，會變更的話，就要用 ref、reactive
- Option API methods 的部份，可直接放在 setup() 中，直接以 變數方式 return !

## ref 版本

- 變數值為 primitive type ，放入 ref() 中，並以 const 來豈告
- 在 setup() 中，如果有存取的話，就要用 變數名.value 的方式來使用 !

```html
<div id="app"
     class="text-center"
     style="display: none">
  <div>
    <data-table v-model:data_items="data_items"
                v-model:page_info="page_info"
                v-on:sort_column="sort_column"></data-table>
    <jquery-ui-select-menu v-if="page_info"
                           v-model:page_info="page_info"
                           v-on:select-value="to_page"></jquery-ui-select-menu>
  </div>
</div>


<script src="https://unpkg.com/vue@next"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>
    const { createApp, ref, onMounted, computed } = Vue;

    const RootComponent = {
        setup() {

            const data_items = ref(null);
            const page_info = ref(null);

            const getDataTable = function() {
                axios.post('/api/Table/GetDataTable',
                                page_info.value,
                                {
                                headers: {
                                    'Content-Type': 'application/json'
                                }
                                })
                        .then(response => {
                            data_items.value = response.data.Data;
                            page_info.value = response.data.PageInfo;
                        });
            };
            const sort_column = function(columnName) {
                page_info.value.ClickSortColumn = columnName;
                getDataTable();
            };

            const to_page = function(pageNo) {
                page_info.value.PageNo = pageNo;
                getDataTable();
            }

            onMounted(() => {
                getDataTable();
            });

            return {
                data_items,
                page_info,
                getDataTable,
                sort_column,
                to_page,
            }
        },
    };

    const app = createApp(RootComponent);

    app.component("data-table", {
        data() {
            return {
                columns : [
                    { columnEngName : 'Id', columnChnName : 'ID'},
                    { columnEngName : 'Name', columnChnName : '姓名'},
                    { columnEngName : 'Age', columnChnName : '年齡'},
                ]
            }
        },
        props:{
            data_items : null,
            page_info : null,
        },
        template: `
    <table class="table" >
    <thead>
    <tr>
    <th v-for="column in columns" @click="sort(column.columnEngName)">
        {{column.columnChnName}}
        <sort-icon v-if="page_info"
                    v-model:page_info="page_info"
                    v-model:target_column="column.columnEngName" ></sort-icon>
    </th>
    </tr>
    </thead>
    <tbody>
    <tr v-if="data_items
            && data_items.length > 0"
        v-for="item in data_items">
        <td>{{item.Id}}</td>
        <td>{{item.Name}}</td>
        <td>{{item.Age}}</td>
    </tr>
    </tbody>
    </table>
    `,
        methods : {
            sort(columnName){
            this.$emit('sort_column', columnName);
            }
        }
    });

    app.component("sort-icon", {
        template: `
    <i :class="classObject"></i>
    `,
        props:{
            page_info : null,
            target_column : null,
        },
        computed: {
            classObject() {

            if (this.page_info.SortColumn === this.target_column)
            {
                if (this.page_info.SortColumnOrder === 1)
                {
                    return { 'bi bi-sort-up': true, }
                }

                if (this.page_info.SortColumnOrder === 0)
                {
                    return { 'bi bi-sort-down-alt': true, }
                }
            }

            return {};
            }
        }
    });

    app.component("jquery-ui-select-menu", {
    props:{
        page_info : null,
    },
    setup(props, { emit }){

        onMounted(() => {
            selectMenuDom = $( "#select-menu" );
            selectMenuDom.selectmenu({
                                        width: 100,
                                        select: function( event, ui ) {
                                            emit('select-value', ui.item.value)
                                        }
                                    });
        })

        let selectMenuDom = null;

        return {
            selectMenuDom,
        }
    },
    template: `
<select id="select-menu" v-model="page_info.PageNo">
<option v-for="pageNo in page_info.PageCount"
        v-bind:value="pageNo"
        >{{ pageNo }}</option>
</select>`,
    });

    const vm = app.mount('#app');

    window.addEventListener('DOMContentLoaded', (event) => {
        document.getElementById("app").style.display = "block";
    });
</script>
```


## reactive 版本

- 相較於 ref + primitive type，reactive 就是給定 object type
- 在 setup() 中，如果有存取的話，不需要像 ref 需要透過 變數.value 來存取 !

```html
<div id="app"
     class="text-center"
     style="display: none">
  <div>
    <data-table v-model:data_items="page_data.data_items"
                v-model:page_info="page_data.page_info"
                v-on:sort_column="sort_column"></data-table>
    <jquery-ui-select-menu v-if="page_data.page_info"
                           v-model:page_info="page_data.page_info"
                           v-on:select-value="to_page"></jquery-ui-select-menu>
  </div>
</div>


<script src="https://unpkg.com/vue@next"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<link rel="stylesheet"
    href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>
    const { createApp, ref, onMounted, computed, reactive } = Vue;

    const RootComponent = {
        setup() {

            const page_data = reactive({
                data_items : null,
                page_info : null,
            });

            const getDataTable = function() {
                axios.post('/api/Table/GetDataTable',
                                    page_data.page_info,
                                    {
                                        headers: {
                                            'Content-Type': 'application/json'
                                        }
                                    })
                        .then(response => {
                            page_data.data_items = response.data.Data;
                            page_data.page_info = response.data.PageInfo;
                        });
            };
            const sort_column = function(columnName) {
                page_data.page_info.ClickSortColumn = columnName;
                getDataTable();
            };

            const to_page = function(pageNo) {
                page_data.page_info.PageNo = pageNo;
                getDataTable();
            }

            onMounted(() => {
                getDataTable();
            });

            return {
                page_data,
                getDataTable,
                sort_column,
                to_page,
            }
        },
    };

    const app = Vue.createApp(RootComponent);

    app.component("data-table", {
        data() {
            return {
                columns : [
                    { columnEngName : 'Id', columnChnName : 'ID'},
                    { columnEngName : 'Name', columnChnName : '姓名'},
                    { columnEngName : 'Age', columnChnName : '年齡'},
                ]
            }
        },
        props:{
            data_items : null,
            page_info : null,
        },
        template: `
    <table class="table" >
    <thead>
    <tr>
    <th v-for="column in columns" @click="sort(column.columnEngName)">
        {{column.columnChnName}}
        <sort-icon v-if="page_info"
                    v-model:page_info="page_info"
                    v-model:target_column="column.columnEngName" ></sort-icon>
    </th>
    </tr>
    </thead>
    <tbody>
    <tr v-if="data_items
            && data_items.length > 0"
        v-for="item in data_items">
        <td>{{item.Id}}</td>
        <td>{{item.Name}}</td>
        <td>{{item.Age}}</td>
    </tr>
    </tbody>
    </table>
    `,
        methods : {
            sort(columnName){
            this.$emit('sort_column', columnName);
            }
        }
    });

    app.component("sort-icon", {
        template: `
    <i :class="classObject"></i>
    `,
        props:{
            page_info : null,
            target_column : null,
        },
        computed: {
            classObject() {

            if (this.page_info.SortColumn === this.target_column)
            {
                if (this.page_info.SortColumnOrder === 1)
                {
                    return { 'bi bi-sort-up': true, }
                }

                if (this.page_info.SortColumnOrder === 0)
                {
                    return { 'bi bi-sort-down-alt': true, }
                }
            }

            return {};
            }
        }
    });

    app.component("jquery-ui-select-menu", {
    props:{
        page_info : null,
    },
    setup(props, { emit }){

        onMounted(() => {
            selectMenuDom = $( "#select-menu" );
            selectMenuDom.selectmenu({
                                        width: 100,
                                        select: function( event, ui ) {
                                            emit('select-value', ui.item.value)
                                        }
                                    });
        })

        let selectMenuDom = null;

        return {
            selectMenuDom,
        }
    },
    template: `
<select id="select-menu" v-model="page_info.PageNo">
<option v-for="pageNo in page_info.PageCount"
        v-bind:value="pageNo"
        >{{ pageNo }}</option>
</select>`,
    });

    const vm = app.mount('#app');

    window.addEventListener('DOMContentLoaded', (event) => {
        document.getElementById("app").style.display = "block";
    });
</script>
```