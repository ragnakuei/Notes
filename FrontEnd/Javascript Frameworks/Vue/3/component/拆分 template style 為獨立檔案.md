# 拆分 template style 為獨立檔案

```ts
<template src="./FormPlugin.html"></template>
<style src="./FormPlugin.css" lang="css" scoped></style>
<script lang="ts">
import { ref } from 'vue';

export default {
    setup(props: {}) {
        const name = ref('Tom');

        return {
            name,
        }
    }
}
</script>
```