# local 範例一

mixins01.ts

```ts
import Vue from 'vue';

export default Vue.extend({
  created () {
    console.log('mixins01 created')
  },
  mounted () {
    console.log('mixins01 mounted')
  }
});
```

Home.vue

```vue
<template>
  <div class="home">
    <img alt="Vue logo" src="../assets/logo.png">
    <HelloWorld msg="Welcome to Your Vue.js + TypeScript App"/>
  </div>
</template>

<script lang="ts">
import Vue from 'vue';
import HelloWorld from '@/components/HelloWorld.vue'; // @ is an alias to /src
import mixins01 from '@/mixins/mixins01';

export default Vue.extend({
  name: 'Home',
  components: {
    HelloWorld,
  },
  mixins: [mixins01],
});
</script>
```
