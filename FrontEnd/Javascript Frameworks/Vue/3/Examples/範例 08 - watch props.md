# 範例 08 - watch props

- 因為 Parent Component 呼叫 Child Component 時，預設無法指定 Computed Set
- 用委派的方式指定 watch 的 property

```html
<div id="app" class="text-center" style="display: none">
  <button @click="toggleChildComponent">Toggle Child Component</button><br />
  <child-component
    v-model:is_show_message="isShowChildComponentMessage"
  ></child-component>
</div>

<script src="https://unpkg.com/vue@next"></script>

<script>
  const { createApp, computed, onMounted, ref, watch } = Vue;

  const app = createApp({
    setup() {
      const isShowChildComponentMessage = ref(true);

      const toggleChildComponent = function () {
        isShowChildComponentMessage.value = !isShowChildComponentMessage.value;
      };

      return {
        isShowChildComponentMessage,
        toggleChildComponent,
      };
    },
  });

  app.component("child-component", {
    props: {
      is_show_message: null,
    },
    setup(props) {
      const changeCount = ref(0);

      watch(
        // 用委派的方式指定 watch 的 property
        () => props.is_show_message,
        (newValue, oldValue) => {
          console.log("watch is_show_message", props.is_show_message);
          changeCount.value++;
        }
      );

      return {
        changeCount,
      };
    },
    template: `
<div id="dialog">
  <div v-if="is_show_message">
    Show Message
  </div>
  <div v-else>
    Hidden Message
  </div>
</div>
<label>{{is_show_message}}</label><br>
<label>{{changeCount}}</label>
`,
  });

  const vm = app.mount("#app");
  window.addEventListener('DOMContentLoaded', (event) => {
    document.getElementById("app").style.display = "block";
  });
</script>
```
