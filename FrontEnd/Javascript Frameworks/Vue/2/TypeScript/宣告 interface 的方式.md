# 宣告 interface 的方式

宣告成 interface 的 DTO 不用初始化欄位值

```ts
export interface TestDto {
    id: number;
    name: string;
}
```

field 宣告方式
- 給定初始值
- 在 field name 後方加上 !，就可以不給定初始值

```html
<template>
    <div>
        <p>
            <label>Id:</label>
            <label>
                <input :value="testDto.id"/>
            </label>
        </p>

        <p>
            <label>Name:</label>
            <label>
                <input :value="testDto.name"/>
            </label>
        </p>
    </div>
</template>
<script lang="ts">
    import { Component, Prop, Vue } from "vue-property-decorator";
    import { TestDto } from "@/components/TestDto";

    @Component({})
    export default class Test extends Vue {
        private testDto: TestDto;

        // 以這個方式宣告，就可以不用在 constructor 中給定初始值
        // private testDto!: TestDto;

        constructor() {
            super();

            this.testDto = { id: 0, name: "" };
        }
    }
</script>

<style scoped>

</style>

```