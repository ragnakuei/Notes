# custom event

## change 範例

change 
- 值改變，並且 blue 後，才會觸發

child component

```html
<template>
    <div>
        <p>
            <label>First Name:</label>
            <input :value="firstName" @change="onChangeFirstName">
        </p>
    </div>
</template>

<script lang="ts">
    import { Component, Prop, Vue } from "vue-property-decorator";

    @Component
    export default class TestChild3 extends Vue {
        constructor() {
            super();

            this.firstName = 'firstName';
        }

        private onChangeFirstName(target: MouseEvent) {
            const input = target?.target as HTMLInputElement;

            // 這邊字串指定 custom event name
            this.$emit("onChangeFirstName", input?.value);
            console.log(`TestChild3.FirstName:${input?.value}`);
        }

        private firstName: string;
    }
</script>
```

指定 child component custom event 要用 `v-on:` 開頭，後面接 custom event name


```html
<template>
    <TestChild3 v-on:onChangeFirstName="onChangeFirstName"
    />
</template>
<script lang="ts">
    import { Component, Vue } from "vue-property-decorator";
    import TestChild3 from "@/views/TestChild3.vue";

    @Component({
        components: { TestChild3, TestChild }
    })
    export default class Test extends Vue {
        private testChild3!: TestChild3;

        constructor() {
            super();

            this.testDto = { id: 0, name: "" };
        }

        private onChangeFirstName(value: string): void {
            console.log(`Test.FirstName:${value}`);
        }

    }
</script>
```