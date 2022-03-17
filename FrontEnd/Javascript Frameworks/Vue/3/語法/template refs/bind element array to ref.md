# bind element array to ref

- template 透過 `v-bind:ref="setItem"` 傳遞 element 至 method setItem() 中
- setItem(element) 直接把 element 放到 Set 中
  - 不要直接把 element push Array 中，會造成 Array 會有重複的資料
  - 最簡單的做法就是丟到 Set 去重複，或是手動進行 Array 去重複的動作


```html
<style>
    [v-cloak] {
        display: none;
    }
    
    .wrapper {
        width: calc(100% - 20px);
        position: absolute;
        border: 1px solid #747474;
        border-radius: 8px;
        box-shadow: 10px 10px 20px #e4e4e4;
        overflow: hidden;
    }

    .scroll-block {
        height: 200px;
        overflow-x: hidden;
        overflow-y: scroll;
    }

    .item {
        width: 100%;
        padding: 5px;
        cursor: pointer;
        background-color: #fff;
        border-bottom: 1px solid #d4d4d4;
    }

    .item:hover {
        background-color: #767676;
        color: #ffffff;
    }
</style>
<div id="app" v-cloak>
    <div class="wrapper">
        <div class="scroll-block">
            <div v-for="(itemOption, itemIndex) in itemOptions" 
                 class="item"
                 v-on:click="clickItemOption(itemOption, itemIndex)"
                 v-bind:ref="setItem">
                {{ itemOption }}
            </div>
        </div>
    </div>
</div>

<script src="https://unpkg.com/vue@next"></script>
<script>
    const {
        createApp,
        ref,
        reactive,
        onMounted,
        computed,
        watch,
        watchEffect
    } = Vue;
    const app = createApp({
        setup() {
            const itemOptions = ref(
                'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('')
            );
            const items = ref(new Set());
            const setItem = function(el) {
                items.value.add(el);
            }
            
            const clickItemOption = function(itemOption, itemIndex) {
                console.log('itemOption',itemOption);
                console.log('items.value[itemIndex]',Array.from(items.value)[itemIndex]);
            }
                        
            return {
                itemOptions,
                items,
                setItem,
                clickItemOption,
            }
        }
    });
    const vm = app.mount('#app');
</script>
```
