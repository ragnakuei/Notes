# local 範例一

local 使用的好處，不會汙染全域的所有 vue 

## 建立要共用的 ts

一定要記得加 `@Component`

```ts
import { Component, Vue } from "vue-property-decorator";

@Component  // 此行一定要加
export default class Mixin01 extends Vue {
    constructor() {
        super();

        console.log('mixin01 constructor');

        this.test = 'test';
    }

    public test: string;

    get count(): number {
        return this.$store.state.count;
    }

    increase(): void {
        let count = this.count;
        count++;

        this.$store.commit('setCount', count);
    }
}

```

## 引用

標示為 // 1 的二個地方 (要註解 // 2)，是使用 mixins 的另一種寫法，可以正常執行，但 IDE 可能不支援

```vue
<template>
    <div>
        <p>
            count
            <input :value="count"/>
        </p>
        <p>
            storeDdat
            <input :value="storeData"/>
        </p>
        <p>
            <button @click="increase">increase</button>
        </p>
    </div>
</template>
<script lang="ts">
    import { Component, Vue } from "vue-property-decorator";
    import { mixins } from "vue-class-component";
    import Mixin01 from "@/mixin/mixin01";

    @Component({
        // mixins: [Mixin01],                // 1
        components: {

        }
    })
    export default class Test extends mixins(Mixin01) {  // 2
    // export default class Test extends Vue {     // 1

        constructor() {
            super();

        }

        mounted() {
            console.log(this.test);
        }

        get storeData(): string {
            return this.$store.state.storeData;
        }
    }
</script>

```