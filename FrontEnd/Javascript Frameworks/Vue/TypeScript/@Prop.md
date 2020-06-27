# @Prop

## 範例

有一個 child component 如下

```html
<template>
    <div>
        <p>
            <label>Name:</label>
            <input :value="name">
        </p>
        <p>
            <label>Age:</label>
            <input :value="age">
        </p>
        <p>
            <label>Message:</label>
            <input :value="msg">
        </p>
    </div>
</template>

<script lang="ts">
    import { Component, Prop, Vue } from "vue-property-decorator";

    @Component
    export default class TestChild extends Vue {
        constructor() {
            super();
        }

        @Prop({default: "default message"}) readonly msg!: string;
        @Prop({ required: true }) name!: string;
        @Prop({ required: true }) age!: number;
    }
</script>

<style scoped>

</style>
```

使用該 child component + @Prop 的方式如下

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

        <!-- 呼叫 child component 的方式，並給定 required property -->
        <TestChild  age="99" name="Required Name"/>
    </div>
</template>
<script lang="ts">
    import { Component, Vue } from "vue-property-decorator";
    import { TestDto } from "@/components/TestDto";
    import TestChild from "@/views/TestChild.vue";

    @Component({
        components: { TestChild }
    })
    export default class Test extends Vue {
        private testDto: TestDto;

        constructor() {
            super();

            this.testDto = { id: 0, name: "" };
        }
    }
</script>
```