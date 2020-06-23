# EventBus

可用於不同 component 間(非父子類關係)的溝通，更進階一點就是用 vuex

[範例](https://ithelp.ithome.com.tw/articles/10204202)

[範例2](https://siddharam.com.tw/post/20200316/)

[Vue中的Event bus跟Router撞出新地雷](https://medium.com/@ceall8650/vue%E4%B8%AD%E7%9A%84event-bus%E8%B7%9Frouter%E6%92%9E%E5%87%BA%E6%96%B0%E5%9C%B0%E9%9B%B7-5d3e52545cec)


## 初始範例

可在 mounted 或 created 階段就註冊 on 事件

```js
const eventBus = new Vue();

Vue.component("product", {
  mounted() {
    eventBus.$on("onChangeSelectedName", (name) => {
      this.message = name;
    });
  },
  template: `
    <div>
      <p>{{ message }}</p>
    </div>
  `,
  data() {
    return {
      message: "",
    };
  },
});

var app = new Vue({
  el: "#app",
  data: {
    names: ["A", "B", "C"],
    selectedName: null,
  },
  methods: {
    onSelectedLi(name) {
      eventBus.$emit("onChangeSelectedName", name);
    },
  },
});
```

view

```html
<html>
  <head>
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  </head>
  <body>
    <div id="app">
      <p>{{ title }}</p>
      <product></product>
      <div>
        <ul>
          <li v-for="(name, index) in names" :key=index 
              @click="onSelectedLi(name)"
          >{{ name }}</li>
        </ul>
      </div>
    </div>
    <script></script>
    <script src="./app.js"></script>
  </body>
</html>
```
