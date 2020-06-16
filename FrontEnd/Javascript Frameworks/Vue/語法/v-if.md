## v-if

```html
<template>
    <div>
        <div v-if="isStock">
            <p>In Stock</p>
        </div>

        <div v-if="isStock == false">
            <p>Out of Stock</p>
        </div>
    </div>
</template>
<script>
    var app = new Vue({
        el: "#app",
        data: {
            product: "a",
            image : 'vmSocks-green.png',
            isStock : true,
        },
    });
</script>
```

## v-else-if

```html
<template>
    <div>
        <div v-if="isStock">
            <p>In Stock</p>
        </div>

        <div v-if="isStock == false">
            <p>Out of Stock</p>
        </div>
    </div>
</template>
<script>
    var app = new Vue({
        el: "#app",
        data: {
            product: "a",
            image : 'vmSocks-green.png',
            isStock : true,
        },
    });
</script>
```

## v-else

```html
<template>
    <div>
        <div v-if="inventory <= 0">
            <p>Out of Stock</p>
        </div>
        <div v-else-if="inventory > 0 && inventory <= 10">
            <p>Between 1 and 10</p>
        </div>
        <div v-else>
            <p>over 10</p>
        </div>
    </div>
</template>
<script>
    var app = new Vue({
        el: "#app",
        data: {
            product: "a",
            image : 'vmSocks-green.png',
            isStock : true,
        },
    });
</script>
```