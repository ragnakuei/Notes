# component template 指定 id 做法

## 範例 01


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

## 範例 02

bootstrap 5 modal

```html
<script id="modal" type="text/x-template">
    <div class="modal fade" v-bind:id="id" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">{{ title }}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <slot name="body"></slot>
                </div>
                <div class="modal-footer">
                    <slot name="footer"></slot>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>
</script>
<script>

    const modal = {
        template: '#modal',
        props: {
            title: String,
            id: String
        },
        setup(props, { emit }) {
            const modalInstance = ref(null);

            function show() {
                modalInstance.value.show();
            }

            function hide() {
                modalInstance.value.hide();
            }

            onMounted(() => {
                modalInstance.value = new bootstrap.Modal(document.getElementById(props.id), {
                    keyboard: false,
                    backdrop: 'static',
                    focus: true,
                })
            })

            return {
                show,
                hide,
            }
        }
    }

</script>
```


