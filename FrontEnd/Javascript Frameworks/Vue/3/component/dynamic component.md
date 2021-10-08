# dynamic component

- 透過 v-bind:is=變數值 來指向 vue component tag
- 區分大小寫

#### 範例一



```html
<div id="app" class="demo">
  <button
     v-for="tab in tabs"
     v-bind:key="tab"
     v-bind:class="['tab-button', { active: currentTab === tab }]"
     v-on:click="currentTab = tab"
   >
    {{ tab }}
  </button>

  <component v-bind:is="currentTabComponent" class="tab"></component>
</div>

<script src="https://unpkg.com/vue@next"></script>
<script>
  const { createApp, ref, reactive, onMounted, computed, watch, watchEffect } = Vue;

  const app = createApp({
    setup() {

      const currentTab = ref('Home');
      const tabs = ref(['Home', 'Posts', 'Archive']);

      const currentTabComponent = computed(() => 'tab-' + currentTab.value );

      return {
        currentTab,
        tabs,
        currentTabComponent,
      }
    },
  });

  app.component('tab-Home', {
    template: `<div class="demo-tab">Home component</div>`
  });
  
  app.component('tab-Posts', {
    template: `<div class="demo-tab">Posts component</div>`
  });
  
  app.component('tab-Archive', {
    template: `<div class="demo-tab">Archive component</div>`
  });
  
  app.mount('#app');
</script>
```