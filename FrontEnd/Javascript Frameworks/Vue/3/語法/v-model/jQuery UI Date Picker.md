# jQuery UI Date Picker

- 在無後端 ajax 同步資料的情況，透過 selectItem 來暫存選取的資料，當進行更新資料時，就從 editItem 將資料更新至 selectItem
- 在有後端 ajax 同步資料的情況，就不透過 selectItem 來暫存選取的資料，而是將選取的資料複製一份至 editItem，當資料更新後，就重新從後端取得資料，並回到初始狀態即可 !
- 注意：
  - 不要搭配 form.reset() 功能，否則會導致 model binding 異常 !


```html
<html lang="en">

<head>
    <meta charset="utf-8">
</head>

<body>

    <p>特點</p>
    <ul>
        <li>整合 input onblur 跟 jQuery UI Date Picker onSelect 的事件，避免重複觸發事件</li>
        <li>事件支援回傳選擇前的值，以及選擇後的值</li>
    </ul>
    <hr />

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/themes/base/jquery-ui.min.css"
          integrity="sha512-ELV+xyi8IhEApPS/pSj66+Jiw+sOT1Mqkzlh8ExXihe4zfqbWkxPRi8wptXIO9g73FSlhmquFlUOuMSoXz5IRw=="
          crossorigin="anonymous"
          referrerpolicy="no-referrer" />
    <div id="app">
        <form autocomplete="off"
              v-on:submit.prevent="submit_form">

            <ul>
                <li v-for="item in items"
                    v-on:click="selectingItem(item)">
                    {{ item.name }} - {{ item.PickDate }}
                </li>
            </ul>

            <p>
                <label for="PickDate">訂單日期：</label>
                <jquery_ui_date_picker id="PickDate"
                                       format="yymmdd"
                                       v-model="editItem.PickDate"></jquery_ui_date_picker>
            </p>
            <p>
                <button type="submit">送出</button>
            </p>
        </form>
    </div>

    <script src="https://unpkg.com/vue@next"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js"
            integrity="sha512-57oZ/vW8ANMjR/KQ6Be9v/+/h6bq9/l3f0Oc7vn6qMqyhvPd1cvKBRWWpzu0QoneImqr2SkmO4MSqU+RpHom3Q=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"></script>
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

                const items = ref([
                    { id: 1, name: 'A', PickDate: '20230102', isActive: false },
                    { id: 2, name: 'B', PickDate: '20230103', isActive: false },
                    { id: 3, name: 'C', PickDate: '20230104', isActive: true },
                    { id: 4, name: 'D', PickDate: '20230105', isActive: false },
                    { id: 5, name: 'E', PickDate: '20230106', isActive: true },
                    { id: 6, name: 'F', PickDate: '20230107', isActive: false },
                    { id: 7, name: 'G', PickDate: '20230108', isActive: false },
                ]);


                const selectItem = ref({});
                const editItem = ref({});
                function selectingItem(item) {
                    console.log('click li', item);
                    if (selectItem.value.id === item.id) {
                        to_empty_mode();
                    } else {
                        to_edit_mode(item);
                    }

                }

                function to_empty_mode() {
                    selectItem.value = {};
                    editItem.value = {};

                }
                function to_edit_mode(item) {
                    selectItem.value = item;
                    editItem.value = { ...item };

                }

                const submit_form = function () {
                    const selectItem = items.value.find(x => x.id === editItem.value.id);
                    // 手動將值寫回去
                    selectItem.PickDate = editItem.value.PickDate;
                }

                return {
                    items,
                    selectingItem,
                    editItem,
                    submit_form,
                }
            }
        });
        app.component('jquery_ui_date_picker', {
            template: `
    <input ref="dom"
           v-bind:id="id"
           v-model="selectDate"
           v-on:focus="focus"
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
                        onSelect: function (dateText, inst) {
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

                function focus() {
                    previousValue.value = dom.value.value;
                    console.log('focus');
                }

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
                    focus,
                    blur,
                }
            }
        });
        const vm = app.mount('#app');
    </script>

</body>

</html>
```