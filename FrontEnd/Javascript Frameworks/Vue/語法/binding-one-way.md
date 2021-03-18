# binding

- [binding](#binding)
  - [範例 - Property Binding](#範例---property-binding)
  - [範例 - Attribute Binding](#範例---attribute-binding)
  - [範例 - Event Binding](#範例---event-binding)
  - [範例 - Style Binding 1](#範例---style-binding-1)
  - [範例 - Style Binding 2](#範例---style-binding-2)
  - [範例 - Style Binding 3](#範例---style-binding-3)
  - [範例 - Style Binding 4](#範例---style-binding-4)
  - [範例 - Class Binding 1](#範例---class-binding-1)
  - [範例 - Class Binding 2](#範例---class-binding-2)
  - [範例 - Class Binding 3](#範例---class-binding-3)
  - [範例 - Class Binding 4](#範例---class-binding-4)
  - [範例 - Class Binding 5](#範例---class-binding-5)

---

## 範例 - Property Binding

```html
<template>
    <div>
        <p>Order</p>
        <div>{{ firstName + ' ' + lastName }}</div>
        <div>{{ fullName() }}</div>
    </div>
</template>

<script>
    export default {
        name: 'order',
        components: {},
        data() {
            return {
                firstName: 'Foo',
                lastName: 'Bar',
            };
        },
        methods: {
            fullName() {
                return this.firstName + ' ' + this.lastName;
            },
        },
    };
</script>
```

---

## 範例 - Attribute Binding

假設要 bind 的 attribute 為 \<img> 的 src  
那 \<img v-bind:src="bind_property" /> 就可以將 `bind_property` 值 bind 至 img `src` 中

```html
<div class="product">
    <div class="product-image">
        <img v-bind:src="image" />
    </div>

    <div class="product-info">
        <h1>{{ product }}</h1>
    </div>
</div>
```

---

## 範例 - Event Binding

event name 可參考[這裡](https://developer.mozilla.org/en-US/docs/Web/Events#Standard_events)

```html
<template>
    <button @click="count++">You clicked me {{ count }} times.</button>
    <!-- 另一種寫法 -->
    <!-- <button v-on:click="count++">You clicked me {{ count }} times.</button> -->
</template>

<script>
    export default {
        data() {
            return {
                count: 0,
            };
        },
    };
</script>
```

## 範例 - Style Binding 1

直接 binding 指定的 property object

```html
<template>
    <div id="app">
        <div class="product" :style="customStyle"></div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                customStyle: {
                    width: 100,
                    height: 50,
                    backgroundColor: 'blue',
                },
            };
        },
    };
</script>
```

## 範例 - Style Binding 2

指定每個 binding 的 property

```html
<template>
    <div id="app">
        <div
            class="product"
            :style="{width:customStyle.width, height:customStyle.height, background:customStyle.backgroundColor}"
        ></div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                customStyle: {
                    width: 100,
                    height: 50,
                    backgroundColor: 'blue',
                },
            };
        },
    };
</script>
```

## 範例 - Style Binding 3

以 array 的方式來給定 style

```html
<template>
    <div id="app">
        <div class="product" :style="[customStyle1, customStyle2]"></div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                customStyle1: {
                    width: 100,
                    height: 50,
                },
                customStyle2: {
                    backgroundColor: 'blue',
                },
            };
        },
    };
</script>
```

## 範例 - Style Binding 4

conditional binding style

符合條件就給定 style="text-decoration:line-through;"

```html
<template>
    <div id="app">
        <p v-else  
            :style = "inStock == false ? {'text-decoration':'line-through'} : {}"
        >Out of Stock</p>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                inStock: false,
            };
        },
    };
</script>
```

---

## 範例 - Class Binding 1

class 的判斷為 bool 值

```html
<template>
    <div id="app">
        <div class="product" :class="{ classA : true, classB : false }"></div>
    </div>
</template>

<script>
    export default {
        data() {
            return {};
        },
    };
</script>
```

## 範例 - Class Binding 2

透過 property 給定的值來判斷是否套用該 class

```html
<template>
    <div id="app">
        <div
            class="product"
            :class="{ classA : isShowClassA, classB : isShowClassB }"
        ></div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                isShowClassA: false,
                isShowClassB: true,
            };
        },
    };
</script>
```

## 範例 - Class Binding 3

透過 property 給定的值來判斷是否套用該 class

```html
<template>
    <div id="app">
        <div class="product" :class="showClass"></div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                showClass: {
                    isShowClassA: false,
                    isShowClassB: true,
                },
            };
        },
    };
</script>
```

## 範例 - Class Binding 4

以 array 的方式來給定 class

```html
<template>
    <div id="app">
        <div
            class="product"
            :style="[customStyle1, customStyle2]"
            :class="[showClassA, showClassB]"
        ></div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                showClassA: {
                    isShowClassA: true,
                },
                showClassB: {
                    isShowClassB: true,
                },
            };
        },
    };
</script>
```

## 範例 - Class Binding 5

以三元運算子給定 class
- 可以直接給定 class string 
- 或是透過 property binding 給定 class string

```html
<template>
    <div id="app">
        <div class="product" 
                :style="[customStyle1, customStyle2]"
                :class="[ isShowClassA ? 'classA' : classB ]"
        >
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                isShowClassA: false,
                classB: 'classB',
            };
        },
    };
</script>
```
