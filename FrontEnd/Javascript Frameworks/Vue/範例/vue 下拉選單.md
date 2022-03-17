# vue 下拉選單

- 初始選擇項目
  - 可以用 undefined 或是 null

```html
<style>
  [v-cloak] {
    display: none;
  }
</style>

<div id="app" v-cloak>
  <div>
    <p>Option Level 1</p>
    <select
      v-model="postModel.optionLevel1"
      v-on:change="changelevel1()"
    >
      <option value="undefined" default disabled>請選擇</option>
      <option v-for="o1 in optionsLevel1" v-bind:value="o1.value">
        {{ o1.text }}
      </option>
    </select>
  </div>

  <hr />

  {{ postModel }}
</div>

<script src="https://unpkg.com/vue@next"></script>
<script>
  const { createApp, ref, reactive, onMounted, computed } = Vue;

  const app = createApp({
    setup() {
      const allOptions = {
        level1: [
          { text: "A1", value: "a1" },
          { text: "A2", value: "a2" },
          { text: "A3", value: "a3" },
        ],
      };

      const optionsLevel1 = ref([]);

      function assignlevel1() {
        optionsLevel1.value = allOptions.level1;
      }

      assignlevel1();


      const postModel = ref({
        optionLevel1: undefined,
      });

      return {
        optionsLevel1,
        postModel,
      };
    },
  });

  const vm = app.mount("#app");
</script>
```