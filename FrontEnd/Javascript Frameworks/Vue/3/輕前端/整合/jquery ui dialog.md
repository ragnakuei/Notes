# jquery ui dialog

## 範例

將 jquery ui dialog 放在 component 內

外部傳入 is_open_dialog:Boolean 用來儲存目前 Dialog 是否已被開啟

目前已知最佳做法如下：

- 呼叫的 component 記得要給定 v-model:is_open_dialog="xxxxx"

```html
<script>
const jqueryUiDialog = {
    template: `
        <div v-bind:id="id" title="Create new user">
            <span>{{ is_open_dialog_prop }}</span>
        </div>
    `,
    props: {
        id : null,
        is_open_dialog : Boolean,
    },

    setup(props, { emit }) {

        let dialogDom = null;

        onMounted(() => {

            dialogDom = $( '#' + props.id );
            dialogDom.dialog({
                  autoOpen: props.is_open_dialog,
                  height: 400,
                  width: 350,
                  modal: true,
                  close: function (event, ui )
                  {
                      
                  },
                //   buttons: {
                //     Ok: function() {
                //         close_dialog();
                //     },
                //     Cancel: function() {
                //         close_dialog();
                //     }
                //   }
                });
        })

        watch(() => props.is_open_dialog, (newValue, oldValue) => {

            console.log('watch:' + newValue);

            if (newValue === true)
            {
                open_dialog();
            }
        });

        const open_dialog = function() {
            dialogDom.dialog( "open" );

            $('.ui-widget-overlay').on('click', function()
            {
                close_dialog();
            });
        }

        const close_dialog = function() {
            dialogDom.dialog( "close" );
            emit('close_dialog');
        }
    },
}

app.component("jquery-ui-dialog", jqueryUiDialog);
</script>
```