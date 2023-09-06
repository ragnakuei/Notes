# AxiosService 範例 01

- [搭配了 Spinner.vue](bootstrap%205/Spinner.md)

AxiosService 
```js
import consts from "../consts";
import axios from "axios";
import spinnerStore from "../store/spinner";

export default new class AxiosService {
    #instance = axios.create( {
        baseURL: consts.hostUrl,
        timeout: 5000,
        headers: {
            Accept: "application/json",
            "Content-Type": "application/json",
            "access-control-allow-origin": consts.hostUrl,
        },
    } );

    constructor() {
        this.initInterceptors();
    }

    initInterceptors() {
        this.#instance.interceptors.request.use(
            ( config ) => {
                spinnerStore.on();
                return config;
            },
            ( err ) => {
                console.log( "request error:", err );
                return Promise.resolve( err );
            }
        );

        this.#instance.interceptors.response.use(
            ( response ) => {
                spinnerStore.off();

                return response;
            },
            ( err ) => {
                // 当响应异常时做一些处理
                if( err && err.response ) {
                    switch( err.response.status ) {
                        case 400:
                            err.message = "请求错误(400)";
                            break;
                        case 401:
                            err.message = "未授权，请重新登录(401)";
                            router.push( "/login" );
                            break;
                        case 403:
                            err.message = "拒绝访问(403)";
                            break;
                        case 404:
                            err.message = "请求出错(404)";
                            break;
                        case 408:
                            err.message = "请求超时(408)";
                            break;
                        case 500:
                            err.message = "服务器错误(500)";
                            break;
                        case 501:
                            err.message = "服务未实现(501)";
                            break;
                        case 502:
                            err.message = "网络错误(502)";
                            break;
                        case 503:
                            err.message = "服务不可用(503)";
                            break;
                        case 504:
                            err.message = "网络超时(504)";
                            break;
                        case 505:
                            err.message = "HTTP版本不受支持(505)";
                            break;
                        default:
                            err.message = `连接出错(${ err.response.status })!`;
                    }
                } else {
                    err.message = "连接服务器失败!";
                }
                console.log( "response error:", err.message );

                return Promise.resolve( err );
            }
        );
    }

    get( apiUrl ) {
        return this.#instance( {
            method: "get",
            url: apiUrl,
        } ).then( ( response ) => {

            // console.log( "response", response );

            return response.data;
        } );
    }

    request( method, apiUrl, body ) {
        return this.#instance( {
            method: method,
            url: apiUrl,
            data: body,
        } ).then( ( response ) => {

            // console.log( "response", response );

            return response.data;
        } );
    }
}
```

store/spinner.js
```js
import { ref, computed } from "vue";

export default new class store {

    #requestCount = ref( [] );

    constructor() {
    }

    on() {
        console.log('on');
        this.#requestCount.value.push('');
    }

    off() {
        console.log('off');
        this.#requestCount.value.pop();
    }

    status = computed (() => {
        console.log( 'this.#requestCount.value.length', this.#requestCount.value.length );
        return this.#requestCount.value.length > 0;
    })
}
```

Spinner.vue
```js
<template>
    <div class='wrapper d-flex justify-content-center'
         v-if='spinnerStore.status.value'>
        <div class='spinner spinner-border'
             role='status'>
            <span class='visually-hidden'>Loading...</span>
        </div>
    </div>
</template>

<script setup>
import { onMounted, ref, computed } from "vue";
import spinnerStore from "../store/spinner";
</script>

<style scoped>
.wrapper {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: rgba(0, 0, 0, 0.2);
    z-index: 100;
}
</style>
```

呼叫方式

```js
import httpMethod from "../consts/httpMethod";
import AxiosService from "./AxiosService";

export default new class TeamMembersService {
    constructor() {
    }

    getAll( teamId ) {
        return AxiosService.request( httpMethod.get, `Teams/${ teamId }/Members` );
    }

    bulkAdd( teamId, body ) {
        return AxiosService.request( httpMethod.post, `Teams/${ teamId }/Members/Add`, body );
    }

    bulkRemove( teamId, body ) {
        return AxiosService.request( httpMethod.delete, `Teams/${ teamId }/Members`, body );
    }
}
```