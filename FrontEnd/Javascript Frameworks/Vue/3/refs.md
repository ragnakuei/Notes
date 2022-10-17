# refs

與 2 版有落差 !

## 範例 01

jquery-ui-select-menu.js

- 外部會直接呼叫這個 component 內的 update_options() !

```js
const jquery_ui_select_menu = {
    template: `
        <select v-bind:id="id"
                v-model="modelValue">
            <option value="null">請選擇</option>
            <option v-for="(item, item_index) in options"
                    v-bind:key="item.Value"
                    v-bind:value="item.Value">
                {{ item.Text }}
            </option>
        </select>
    `,
    props: {
        id: String,
        options : Array,
        modelValue: Number,
        width: Number,
    },
    setup(props, {emit}) {

        const options = ref(props.options || []);
        let dom = $("#"+ props.id);

        onMounted(() => {
            dom = $("#"+ props.id);
            dom.selectmenu({
                width: props.width,
                change: function (event, ui) {
                    emit('update:modelValue', parseInt(ui.item.value));
                    emit('change', parseInt(ui.item.value))
                }
            });
        })

        // 讓外部 component 存取的 function
        const update_options = async function (import_options) {
            options.value =  import_options;

            if(dom.selectmenu( "instance" )) {
                await nextTick();
                dom.selectmenu( "refresh" );
            }
        }

        return {
            options,
            update_options,
        }
    },
}
```

外層 component

```html
<style>
  [v-cloak] {
    display: none;
  }
</style>

<div id="app"
     v-cloak>
    <form autocomplete="off"
          v-on:submit.prevent="submit_form">
        <div>
            <label>項目1：</label>
            <!-- 注意下方 ref 語法 -->
            <jquery-ui-select-menu ref="ref_options1"
                                   v-model="vue_model.OptionId1"
                                   v-bind:id="'OptionId1'"
                                   v-bind:width=200
                                   v-on:change="refresh_option2($event);">
            </jquery-ui-select-menu>
        </div>
        <div>
            <label>項目2：</label>
            <!-- 注意下方 ref 語法 -->
            <jquery-ui-select-menu ref="ref_options2"
                                   v-model="vue_model.OptionId2"
                                   v-bind:id="'OptionId2'"
                                   v-bind:width=200
                                   v-on:change="refresh_option3($event);">
            </jquery-ui-select-menu>
        </div>
        <div>
            <label>項目3：</label>
            <!-- 注意下方 ref 語法 -->
            <jquery-ui-select-menu ref="ref_options3"
                                   v-model="vue_model.OptionId3"
                                   v-bind:id="'OptionId3'"
                                   v-bind:width=200 >
            </jquery-ui-select-menu>
        </div>
        <p>
            <button type="submit">送出</button>
        </p>
    </form>
    <p>
        <a v-bind:href="prev_url">回上一層</a>
    </p>
</div>

@section Scripts
{
    <partial name="_Antiforgery" />
    <script src="/lib/CustomFetch.js?20210608001"></script>
    <script>
      const app = createApp({
        setup(){

          const post_url = '@Url.Action("PostCase01")';
          const prev_url = '@Url.Action("Index", "Home")';
          const get_child_options_url = '@Url.Action("GetChildOptions")';

          const vue_model = ref(@Html.Raw(Model.ToJson()));

          // 注意下方 ref 語法
          const ref_options1 = ref(null);
          const ref_options2 = ref(null);
          const ref_options3 = ref(null);

          onMounted(() => {
              refresh_option1();
          });

          const get_child_options = async function (id) {
            return await CustomFetch.PostJson(get_child_options_url, id);
          };

          const refresh_option1 = async function () {

              vue_model.value.OptionId1 = null;
              const options1 = await get_child_options(null);

              // 直接呼叫 chile component 的 function
              ref_options1.value.update_options(options1);

              refresh_option2(null);
          };

          const refresh_option2 = async function (optionId1) {
              vue_model.value.OptionId2 = null;

              if (optionId1) {
                  const options2 = await get_child_options(optionId1);

                  // 直接呼叫 chile component 的 function
                  ref_options2.value.update_options(options2);
              } else {
                  ref_options2.value.update_options(null);
              }

              refresh_option3(null);
          };

          const refresh_option3 = async function (optionId2) {
              vue_model.value.OptionId3 = null;

              if (optionId2) {
                  const options3 = await get_child_options(optionId2);

                  // 直接呼叫 chile component 的 function
                  ref_options3.value.update_options(options3);
              } else {
                  ref_options3.value.update_options(null);
              }
          };

          const submit_form = function() {
              CustomFetch.PostJson(post_url, vue_model.value)
                         .then(data => vue_model.value = data);
          }

          return {
              post_url,
              prev_url,

              vue_model,

              ref_options1,
              ref_options2,
              ref_options3,

              get_child_options,
              refresh_option2,
              refresh_option3,
              submit_form,
          }
        }
      });
    </script>
    <script src="/lib/jquery-ui-select-menu.js?20210608001"></script>
    <script>
      app.component("jquery-ui-select-menu", jquery_ui_select_menu);

      const vm = app.mount('#app');
    </script>
}
```


## 範例 02： binding 多筆 ref

- 只能用 ref，不能用 reactive !
- 不能放在 ref value 的某個 property 內 ! 一定要直接指定至 ref 變數中 !

```Html
<style>
  #app {
      height : 500px;
      overflow-y: scroll;
  }
  
  #item {
    
  }
</style>
<div id="app">
  <div id="item" v-for="(item, index) in vue_model.items" ref="item_doms">
    {{ item }}
  </div>
</div>

<script src="https://unpkg.com/vue@next"></script>
<script>
  const { createApp, ref, reactive, onMounted, computed, watch, watchEffect } = Vue;
  
 const app = createApp({
        setup(){

          const vue_model = ref({ 
            items : Array.from(Array(100).keys()),
            item_doms: []
          });
          
          const item_doms = ref([]);

          onMounted(() => {
            item_doms.value[97]?.scrollIntoView();
          })
          
          return {
              vue_model,
              item_doms,
          }
        }
      });

      const vm = app.mount('#app');
</script>
```