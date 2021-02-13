# 範例 01 - Table 欄位排序 & jQuery UI SelectMenu

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


<script src="https://unpkg.com/vue@3.0.5/dist/vue.global.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<link rel="stylesheet"
    href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>
    const { createApp, ref, onMounted, computed } = Vue;

    const RootComponent = {
    data() {
        return {
            data_items : null,
            page_info : null,
        }
    },
    mounted() {
        this.getDataTable();
    },
    methods : {
        getDataTable(){
        axios.post('/api/Table/GetDataTable',
                    this.page_info,
                    {
                        headers: {
                        'Content-Type': 'application/json'
                        }
                    })
                        .then(response => {
                            this.data_items = response.data.Data;
                            this.page_info = response.data.PageInfo;
                        });
        },
        sort_column(columnName){
        this.page_info.ClickSortColumn = columnName;
        this.getDataTable();
        },
        to_page(pageNo){
        this.page_info.PageNo = pageNo;
        this.getDataTable();
        }
    }
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