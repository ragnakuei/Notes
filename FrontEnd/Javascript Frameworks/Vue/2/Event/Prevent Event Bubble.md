# Prevent Event Bubble

---

先了解 [Event](../../../../../技術/Event%20Bubble.md)

Event Bubble 就是相同事件，會持續往上層 DOM 觸發

### 範例

li 裡面包住了一個 button，li 與 button 都有各自的 click 事件

會在觸發 button click 時，同時也觸發了 li click

這就是 Event Bubble

```html
<template>
  <div>
    Test
    <ul>
      <li @click="onClickli">
        1
        <button @click="onClickButtonInli">Info</button>
      </li>
    </ul>
  </div>
</template>

<script>

export default {
  name: "test",
  components: {},
  methods : {
      onClickli(){
          console.log('onClickli');
      },
      onClickButtonInli(){
          console.log('onClicklonClickButtonInli');
      },
  }
};
</script>
```

防止 Event Bubble 的方式

在 button  的 @click 事件加上 .stop !

```html
<button @click.stop="onClickButtonInli">Info</button>
```