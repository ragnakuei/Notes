# refs



## 範例

如果要從 refs 取出 insatnce 並轉型放到 field 中，最快要在 `mounted()` 才抓得到資料

```html
<template>
    <TestChild3 ref="child3" />
</template>
<script lang="ts">
    import { Component, Vue } from "vue-property-decorator";
    import TestChild from "@/views/TestChild.vue";
    import TestChild3 from "@/views/TestChild3.vue";

    @Component({
        components: { TestChild3 }
    })
    export default class Test extends Vue {
        private testChild3!: TestChild3;

        constructor() {
            super();
        }

        mounted() {
            this.testChild3 = (this.$refs)?.child3 as TestChild3;
        }
    }
</script>
```

