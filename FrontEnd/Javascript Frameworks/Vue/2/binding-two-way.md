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

