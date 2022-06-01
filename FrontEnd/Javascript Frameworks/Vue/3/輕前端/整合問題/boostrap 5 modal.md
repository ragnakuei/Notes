# bootstrap 5 modal

## Cannot read property 'classList' of undefined

原因：太早呼叫 Modal 初始化動作，傳入 undefined / null 至 new bootstrap.Modal() 中 !
解法：在 onMounted 時初始化 Modal !

### 輕前端版本

```html
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

<div id="app">

    <button type="button" v-on:click="open_modal()">Open Modal</button>

    <div ref="modal_dom" class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    ...
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary">Close</button>
                    <button type="button" class="btn btn-primary" v-on:click="close_modal()">Save changes</button>
                </div>
            </div>
        </div>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://unpkg.com/vue@next"></script>
<script>
    document.addEventListener("DOMContentLoaded", async function(event) {
        const { createApp, ref, reactive, onMounted, computed, watch, watchEffect } = Vue;
        const app = createApp({
            setup() {
                
                const modal_dom = ref(null);
                let modal;
                onMounted(() => {
                    // 要等 mounted 後，再抓 boostrap modal dom !
                    modal = new bootstrap.Modal(modal_dom.value);
                })
                
                const open_modal = function() {
                    console.log('open modal');
                    modal.show();
                }
                const close_modal = function() {
                    console.log('close modal');
                    modal.hide();
                }
                return {
                    modal_dom,
                    open_modal,
                    close_modal,
                }
            }
        });
        const vm = app.mount('#app');
    });
</script>
```

### script setup 版本

```js
import { computed, defineProps, onMounted, ref, watch } from "vue";
import { Modal } from "bootstrap";

const emit = defineEmits( [ "update:isOpen" ] );
const props = defineProps( {
    id: String,
    title: String,
    isOpen: Boolean,
} );

let modal = null;
onMounted(() => {
    modal = new Modal(document.getElementById(props.id), {
        backdrop: true,
        keyboard: true,
        focus: true,
    });

    const modalDom = document.getElementById(props.id)
    modalDom.addEventListener('hidden.bs.modal', function (event) {
        isOpen.value = false;
    });
});
```