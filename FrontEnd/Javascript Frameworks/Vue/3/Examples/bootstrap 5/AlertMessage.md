# AlertMessage

## 範例 01

- 記得要放在最外層的 component template 內

```js
<template>
  <svg xmlns='http://www.w3.org/2000/svg'
       style='display: none'>
    <symbol id='check-circle-fill'
            fill='currentColor'
            viewBox='0 0 16 16'>
      <path d='M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z'/>
    </symbol>
    <symbol id='info-fill'
            fill='currentColor'
            viewBox='0 0 16 16'>
      <path d='M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2z'/>
    </symbol>
    <symbol id='exclamation-triangle-fill'
            fill='currentColor'
            viewBox='0 0 16 16'>
      <path d='M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z'/>
    </symbol>
  </svg>

  <div v-if='alertMessageStore.status.value'
       class='alert-container'>
    <div class='alert d-flex align-items-center'
         v-bind:class='alertCssClass'
         role='alert'>
      <svg class='bi flex-shrink-0 me-2'
           width='24'
           height='24'
           role='img'
           aria-label='Success:'>
        <use v-bind:xlink:href='svgId'/>
      </svg>
      <div class='alert-content'>
        {{ alertMessageStore.option.value.message }}
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref, computed } from "vue";
import alertMessageStore from "@/store/alertMessage";
import messageType from "../consts/messageType";

const svgId = computed( () => {
    switch( alertMessageStore.option.value.messageType ) {
        case messageType.info:
            return "#info-fill";
        case messageType.warning:
        case messageType.danger:
            return "#exclamation-triangle-fill";
        case messageType.success:
        default:
            return "#check-circle-fill";
    }
} );

const alertCssClass = computed( () => {
    let result = {};

    switch( alertMessageStore.option.value.messageType ) {
        case messageType.info:
            result["alert-info"] = true;
            break;
        case messageType.warning:
            result["alert-warning"] = true;
            break;
        case messageType.danger:
            result["alert-danger "] = true;
            break;
        case messageType.success:
        default:
            result["alert-success"] = true;
            break;
    }

    return result;
} );
</script>

<style scoped>
@media screen and (min-width: 376px) and (max-width: 1920px) {
    .alert-content {
        white-space: nowrap;
    }
}

@media screen and (max-width: 375px) {
    .alert-container {
        left: 10px;
    }
}

.alert-container {
    top: 100px;
    left: 50%;
    position: fixed;
    display: flex;
    align-items: flex-end;
    transform: translate(-50%, -50%);
    z-index: 1000;
}

.alert {
    padding: 0;
    border: 0;
    width: 100%;
    animation: alert-animation 3s 1;
}

.alert > svg {
    height: 0;
    animation: alert-svg-animation 3s 1;
}

.alert-content {
    height: 0;
    overflow: hidden;
    animation: alert-content-animation 3s 1;
}

@keyframes alert-animation {
    0% {
        width: 56px;
        padding: 1rem 1rem;
    }

    33% {
        width: 100%;
    }

    100% {
        padding: 1rem 1rem;
    }
}

@keyframes alert-svg-animation {
    0% {
        height: 24px;
    }

    100% {
        height: 24px;
    }
}

@keyframes alert-content-animation {
    0% {
        height: auto;
    }

    100% {
        height: auto;
    }
}
</style>
```

store/alertMessage.js

```js
import { ref, computed } from "vue";
import messageType from "../consts/messageType";

export default new class store {

    #status = ref( false );
    #option = ref( {} );
    #timeout = ref( 3000 );

    constructor() {
    }

    option = computed( () => {
        return this.#option.value;
    } );
    status = computed( () => {
        return this.#status.value;
    } );

    on(option = { message : '', messageType : messageType.success }) {
        // console.log('alert message on');

        this.#option.value = option;
        
        this.#status.value = false;
        setTimeout( () => {
            this.off();
        }, this.#timeout.value );
        this.#status.value = true;
    }

    off() {
        // console.log('alert message off');
        
        this.#status.value = false;
    }
}
```

consts/messageType.js

```js
export default {
    success: 'success',
    info: 'info',
    warning: 'warning',
    danger: 'danger ',
}
```

呼叫端語法

```js
alertMessageStore.on({ 
    message: 'Channel updated successfully !',
    messageType: messageType.success,
})
```