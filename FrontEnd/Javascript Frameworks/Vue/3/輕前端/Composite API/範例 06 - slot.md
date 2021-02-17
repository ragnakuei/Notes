# 範例 06 - slot

- 呼叫 component 時，給定其 innter html，並套用至 component 內

```html
<div id="app" class="text-center" style="display: none">
  <slot-component>A</slot-component><br />
  <slot-component>B</slot-component><br />
</div>

<script src="https://unpkg.com/vue@next"></script>

<script>
  const { createApp } = Vue;

  const app = createApp({});

  app.component("slot-component", {
    template: `
<label>
  <slot></slot>
</label>`,
  });

  const vm = app.mount("#app");
  document.getElementById("app").style.display = "block";
</script>
```
