# 待 study child component 指定 id 做法


```html
<!-- template for the modal component -->
<script type="text/x-template" id="modal-template">
    <div class="modal-mask">
      <div class="modal-wrapper">
        <div class="modal-container">

          <div class="modal-header">
            <slot name="header">
              default header
            </slot>
          </div>  

          <div class="modal-body">
            <slot name="body">
              default body
            </slot>
          </div>

          <div class="modal-footer">
            <slot name="footer">
              default footer
              <button class="modal-default-button" @click="$emit('close')">
                OK
              </button>
            </slot>
          </div>
        </div>
      </div>
    </div>
</script>

<!-- app -->
<div id="app">
  <button id="show-modal" @click="showModal = true">Show Modal</button>
  <!-- use the modal component -->
  <transition name="modal">
    <modal v-if="showModal" @close="showModal = false">
      <!--
        you can use custom content here to overwrite
        default content
      -->
      <template v-slot:header>
        <h3>custom header</h3>
      </template>
    </modal>
  </transition>
</div>
```


```js
const app = Vue.createApp({
  data: function() {
    return {
      showModal: false
    }
  }
});

// register modal component
app.component("modal", {
  template: "#modal-template"
});

app.mount('#app');
```

