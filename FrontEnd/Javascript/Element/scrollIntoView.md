# [scrollIntoView](https://developer.mozilla.org/en-US/docs/Web/API/Element/scrollIntoView)

```js
Element.scrollIntoView({behavior: "smooth", block: "center", inline: "nearest"})
```

三個參數

- behavior
- block
- inline

### vue 3 composition api + custom dropdown 範例

```html
<style>
    [v-cloak] {
        display: none;
    }
    
    .form-field {
        margin-bottom: 10px;
    }
    
    .custom-select {
        position: relative;
    }

    .form-control {
        width: calc(100% - 20px);
        border: 1px solid #747474;
        border-radius: 8px;
        height: 30px;
        padding: 0 5px;
    }

    .wrapper {
        width: calc(100% - 20px);
        position: absolute;
        margin-top: 5px;
        border: 1px solid #747474;
        border-radius: 8px;
        box-shadow: 10px 10px 20px #e4e4e4;
        overflow: hidden;
        z-index: 99;
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

    .item.hover {
        background-color: #767676;
        color: #ffffff;
    }

    .wrapper-overlay {
        position: fixed;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        z-index: 98;
    }
</style>
<div id="app" v-cloak>
    <form autocomplete="off" v-on:submit.prevent="submit_form">
        <div class="form-field custom-select">
            <label for="item1">Item1</label>
            <input id="item1"
                   v-model="inputValue" 
                   class="form-control" 
                   v-on:focus="openItemOptions()" 
                   v-on:keydown.tab="tabBlurDom()" 
                   v-on:keydown.up="changeHoverItemOption(-1)" 
                   v-on:keyup.up="enableMouseMoveCheck()" 
                   v-on:keydown.down="changeHoverItemOption(1)" 
                   v-on:keyup.down="enableMouseMoveCheck()" 
                   v-on:keydown.enter.prevent="selectHoverItemOption()">
            <div v-if="showOptions" class="wrapper">
                <div class="scroll-block" ref="scrollBlock">
                    <div v-for="itemOption in itemOptions" 
                         class="item"
                         v-bind:class="itemClass(itemOption)"
                         v-on:mousemove="mouseOveringItemOption(itemOption)"
                         v-on:click="clickItemOption(itemOption)">
                        {{ itemOption }}
                    </div>
                </div>
            </div>
            <div v-if="showOptions" class="wrapper-overlay" v-on:click="closeItemOptions()">
            </div>
        </div>
        <div class="form-field">
            <label for="item2">Item2</label>
            <select id="item2" class="form-control">
                <option v-for="itemOption in itemOptions">
                    {{ itemOption }}
                </v>
            </select>
        </div>
    </form>
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
            const inputValue = ref();
            const itemOptions = ref(
                'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('')
            );
            const scrollBlock = ref({});
            const items = computed({
                get: (v) => {                    
                    return scrollBlock.value.getElementsByClassName('item');
                }
            });
            
            const showOptions = ref(false);
            const openItemOptions = function() {
                showOptions.value = true;
            }
            const closeItemOptions = function() {
                showOptions.value = false;
            }
            const tabBlurDom = function( ) {
                closeItemOptions();
            }
            // hover 項目
            const hoverOption = ref({});
            
            const disableMouseMoveCheck = ref(false);
            const mouseOveringItemOption = function(itemOption) {
                
                if(disableMouseMoveCheck.value) {
                    return;
                }
                
                hoverOption.value = itemOption;
            }
            
            const enableMouseMoveCheck = function() {
                disableMouseMoveCheck.value = false;
            }
            
            const changeHoverItemOption = function(indexOffset) {
                
                disableMouseMoveCheck.value = true;
                
                openItemOptions();

                const currentIndex = itemOptions.value.indexOf(hoverOption.value);
                let targetIndex = currentIndex + indexOffset;
                
                if(targetIndex < 0) {
                    targetIndex = 0;
                }
                
                if(targetIndex > itemOptions.value.length -1 ) {
                    targetIndex = itemOptions.value.length - 1;
                }
                
                items.value[targetIndex].scrollIntoView({behavior: "smooth", block: "center", inline: "nearest"});
                
                hoverOption.value = itemOptions.value[targetIndex];
            }
            // 按下 enter 選取 hoverItemOption
            const selectHoverItemOption = function( ) {
                clickItemOption(hoverOption.value);
            }
            const clickItemOption = function(itemOption) {
                inputValue.value = itemOption;
                closeItemOptions();
            }
            // 用來標示 ItemOption Item 的 class
            const itemClass = function(itemOption) {
                return {
                    "hover" : itemOption === hoverOption.value,
                }
            }
            const submit_form = function() {
                console.log('submit');
            }
            return {
                inputValue,
                itemOptions,
                scrollBlock,
                showOptions,
                openItemOptions,
                closeItemOptions,
                mouseOveringItemOption,
                enableMouseMoveCheck,
                changeHoverItemOption,
                selectHoverItemOption,
                tabBlurDom,
                clickItemOption,
                itemClass,
                submit_form,
            }
        }
    });
    const vm = app.mount('#app');
</script>
```

