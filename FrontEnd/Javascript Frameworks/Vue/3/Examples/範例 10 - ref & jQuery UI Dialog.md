# 範例 10 - ref & jQuery UI Dialog

### 範例一

- 與 [範例9](./範例%2009%20-%20emit%20&%20jQuery%20UI%20Dialog.md) 相同效果，但做法不同 !
- ref 放在 dom 上面，再 setup() 中宣告同名的 field，就可以達成 vue2 $refs 的效果 !
- 由 parent component 直接呼叫 child component 的 method !

```html
<div id="app" class="text-center" style="display: none">
  <button class="btn btn-dark" @@click="showDialogA">Toggle Dialog A</button>&nbsp
  <button class="btn btn-dark" @@click="showDialogB">Toggle Dialog B</button><br />
  <jquery-ui-dialog ref="dialogA" v-on:close_dialog="CloseDialogA">
    A
  </jquery-ui-dialog>
  <jquery-ui-dialog ref="dialogB" v-on:close_dialog="CloseDialogB">
    B
  </jquery-ui-dialog>
</div>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script src="https://unpkg.com/vue@next"></script>

<script>
  const { createApp, computed, onMounted, ref, watch } = Vue;

  const app = createApp({
    setup() {
      const dialogA = ref(null);
      const dialogB = ref(null);

      const showDialogA = function () {
        dialogA.value.showDialog();
      };

      const showDialogB = function () {
        dialogB.value.showDialog();
      };

      const CloseDialogA = function () {
        console.log("dialogA is closed");
      };

      const CloseDialogB = function () {
        console.log("dialogB is closed");
      };

      return {
        dialogA,
        dialogB,
        showDialogA,
        showDialogB,
        CloseDialogA,
        CloseDialogB,
      };
    },
  });

  app.component("jquery-ui-dialog", {
    setup(props, { emit }) {
      const dialogDom = ref(null);

      const showDialog = function () {
        dialogDom.value.dialog("open");
      };

      onMounted(() => {
        dialogDom.value = $("#dialog").dialog({
          autoOpen: false,
          width: "auto",
          modal: true,
          close: function (event, ui) {
            emit("close_dialog");
          },
        });
      });

      return {
        showDialog,
      };
    },
    template: `
<div id="dialog">
  <slot></slot>
</div>
`,
  });

  const vm = app.mount("#app");
  window.addEventListener('DOMContentLoaded', (event) => {
    document.getElementById("app").style.display = "block";
  });
</script>
```



### 範例二：整合事件

- 整合 input onblur 跟 jQuery UI Date Picker onSelect 的事件，避免重複觸發事件
- 事件支援回傳選擇前的值，以及選擇後的值

```html
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.min.css" integrity="sha512-ELV+xyi8IhEApPS/pSj66+Jiw+sOT1Mqkzlh8ExXihe4zfqbWkxPRi8wptXIO9g73FSlhmquFlUOuMSoXz5IRw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<div id="app">
    <form autocomplete="off" v-on:submit.prevent="submit_form">
        <p>
            <label for="OrderDate">訂單日期：</label>
            <jquery_ui_date_picker id="OrderDate" v-model="vmodel.OrderDate" v-on:select="validateOrderDate" ></jquery_ui_date_picker>
        </p>
        <p>
            <button type="submit">送出</button>
        </p>
    </form>
</div>

<script src="https://unpkg.com/vue@next"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js" integrity="sha512-57oZ/vW8ANMjR/KQ6Be9v/+/h6bq9/l3f0Oc7vn6qMqyhvPd1cvKBRWWpzu0QoneImqr2SkmO4MSqU+RpHom3Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
    const {
        createApp,
        ref,
        onMounted,
        computed,
    } = Vue;
    let debounceTimerId;

    function debounce(func, delay) {
        if (debounceTimerId) {
            clearTimeout(debounceTimerId);
        }
        debounceTimerId = setTimeout(func, delay);
    }
    const app = createApp({
        setup() {
            const vmodel = ref({
                OrderDate: ''
            });
            function validateOrderDate(value, previousValue) {
                console.log('OrderDate previous value', previousValue);
                console.log('OrderDate current value', value);
            }
            const submit_form = function() {
                console.log('submit');
            }
            return {
                vmodel,
                validateOrderDate,
                submit_form,
            }
        }
    });
    app.component('jquery_ui_date_picker', {
        template: `
<input ref="dom"
       v-bind:id="id" 
       v-model="selectDate"
       v-on:focus="previousValue = selectDate"
       v-on:blur="blur" />
         `,
        props: {
            id: String,
            format: String,
            modelValue: String,
        },
        emits: ['update:modelValue', 'select'],
        setup(props, { emit }) {
            const dom = ref(null);
            const previousValue = ref(null);
            const format = props.format || "yy-mm-dd";
            onMounted(() => {
                datePickerDom = $("#" + props.id);
                datePickerDom.datepicker({
                    dateFormat: format,
                    changeMonth: true,
                    changeYear: true,
                    onSelect: function(dateText, inst) {
                        selectDate.value = dateText;                        
                        emitSelectDate(dateText);
                        console.log('onSelect');
                    }
                });
            })
            
            let datePickerDom = null;
            const selectDate = computed({
                get: () => props.modelValue,
                set: (v) => {
                    emit('update:modelValue', v);
                },
            });

            function blur() {
                emitSelectDate(dom.value.value);
                console.log('blur');
            }
            
            function emitSelectDate(value) {
                debounce(() => {
                    emit('select', value, previousValue.value);
                }, 100);
            }
            
            return {
                dom,
                previousValue,
                datePickerDom,
                selectDate,
                blur,
            }
        }
    });
    const vm = app.mount('#app');
</script>
```