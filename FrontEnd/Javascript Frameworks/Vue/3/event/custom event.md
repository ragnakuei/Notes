# custom event

## 範例一

- v-on:select-value="to_page($event)"
  - 等於 v-on:select-value="to_page"

- custom event name：select-value

```html
<jquery-ui-select-menu v-if="vueModel.page_info"
                        v-model:page_info="vueModel.page_info"
                        v-on:select-value="to_page($event)">
</jquery-ui-select-menu>
```

vue component

```js
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
```