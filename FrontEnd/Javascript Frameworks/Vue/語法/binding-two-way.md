# binding-two-way

[Form Input Bindings](https://vuejs.org/v2/guide/forms.html)

## v-model

在不同的 dom 上面，的解析方式不同 !

-   text and textarea elements use value property and input event;
-   checkboxes and radiobuttons use checked property and change event;
-   select fields use value as a prop and change as an event.

[modifier](https://vuejs.org/v2/guide/forms.html#Modifiers)

## 範例一

```js
Vue.component('product', {
    template: `
    <div>
      <input v-model="count" />
      <button @click=plusCount >Add Count</button>
    </div>
  `,
    data() {
        return {
            count: 0,
        };
    },
    methods: {
        plusCount() {
            this.count++;
        },
    },
});
```

## checkbox 值的轉換

給定 property 值為 yes 時，要勾選 checkbox

```js
Vue.component("product", {
  template: `
    <div>
      <input
        type="checkbox"
        v-model="toggle"
        true-value="yes"
        false-value="no"
      >
    </div>
  `,
  data() {
    return {
      toggle : 'yes',
    };
  },
});
```

## select 範例

- selected 為被選取的物件
- selectChange 為 change 事件，可以用來取出 option text

```js
Vue.component("product", {
    template: `
        <div>
        <select v-model="selected" @change="selectChange">
            <option v-bind:value="{ number: 1, text: 'A' }">A1</option>
            <option v-bind:value="{ number: 2, text: 'B' }">B1</option>
            <option v-bind:value="{ number: 3, text: 'C' }">C1</option>
        </select>
        </div>
    `,
    data() {
        return {
        selected : { number: 2, text: 'B' },
        };
    },
    methods: {
        selectChange(e) {
        console.log(e);
        console.log(e.target.selectedOptions[0]);
        }
    },
});
```

## number 範例

- 預設 model binding 至 input 都是以字串方式
- 在 v-model 後面加上 .number 就可以指定以 number 來解析
- 如果輸入 非數字 的字元，則不會進行 binding !

```html
<div id="app" class="text-center" style="display: none">
  <input type="text" v-model.number="vm.Count" />
  <label>{{JSON.stringify(vm)}}</label><br>
</div>

<script src="https://unpkg.com/vue@next"></script>

<script>
  const {
    createApp,
    reactive,
  } = Vue;
  const app = createApp({
    setup() {
      const vm = reactive({ Count: 0})
      return {
        vm,
      }
    }
  });
  const vm = app.mount('#app');
  window.addEventListener('DOMContentLoaded', (event) => {
    document.getElementById("app").style.display = "block";
  });
</script>
```