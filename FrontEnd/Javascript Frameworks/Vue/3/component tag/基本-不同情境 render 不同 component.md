 # 基本-不同情境 render 不同 component

 ## 範例

當在 edit 輸入資料後，未按下按鈕，再切換至 list，再切換回 edit，會發現資料消失了 ( 狀態無法被保留 )

```html
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- dynamic component is -->
        <meta charset="UTF-8">
        <title>Vue Example</title>
        <style>
            [v-cloak] {
                display: none;
            }
        </style>
    </head>
    <body>


        <div id='app' v-cloak>

            <p>showComponent: {{showComponent}}</p>
            <button @click="showComponent = 'list'">Show List</button>
            <button @click="showComponent = 'edit'">Show Edit</button>
            
            <hr/>
            
            <!-- 可以統一給定 prop ary -->
            <component :is="showComponent" v-bind:ary="ary"></component>
            
        </div>


        <script src="https://unpkg.com/vue@next"></script>
        <script>
            const {createApp, ref, reactive, onMounted, computed} = Vue;

            createApp({
                setup() {

                    const showComponent = ref('');
                    
                    const ary = ref([1, 2, 3]);

                    onMounted(() => {

                    })
                    return {
                        showComponent,
                        ary,
                    }
                }
            }).component('list', {
                template: `
                  <h3>List</h3>
                  <ul>
                    <li v-for="item in ary" :key="item">
                      {{ item }}
                    </li>
                  </ul>
                `,
                props: {
                    ary: Array,
                },
                setup() {

                    return {}
                }
            }).component('edit', {
                template: `
                  <h3>Edit</h3>
                  <input type="text" v-model="inputValue"/>
                  <button @click="addItem">Add Item</button>
                `,
                props: {
                    ary: Array,
                },
                setup(props) {
                    const inputValue = ref('');

                    function addItem() {
                        props.ary.push(inputValue.value);
                        inputValue.value = '';
                    }

                    return {
                        inputValue,
                        addItem
                    }
                }
            }).mount('#app');
        </script>

    </body>
</html>

```


 ## 保留被切換的 component 的狀態

當在 edit 輸入資料後，未按下按鈕，再切換至 list，再切換回 edit，要如何保留資料呢？

 - 在 <component> 外面以 keep-alive 包住，就可以了 !

從

```html
<component :is="showComponent" v-bind:ary="ary"></component>
```

改成

```html
<keep-alive>
    <component :is="showComponent" v-bind:ary="ary"></component>
</keep-alive>
```

就可以了 !

```html