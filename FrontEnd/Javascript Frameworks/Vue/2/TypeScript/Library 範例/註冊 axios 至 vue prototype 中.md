# 註冊 axios 至 vue prototype 中

## 建立 AxiosService.ts

- 之後可直接用 instance 來發 request

```ts
import axios, { AxiosInstance } from 'axios';
import router from '@/router';

export class AxiosService {
    public instance: AxiosInstance;

    private readonly baseUrl: string;

    constructor() {
        this.instance = axios.create({
            baseURL: process.env.VUE_APP_ApiHost,
            timeout: 5000,
            headers: {
                Accept: 'application/json',
                'Content-Type': 'application/json',
                'access-control-allow-origin': process.env.baseURL,
            },
        });

        this.initInterceptors();
    }

    private initInterceptors() {
        this.instance.interceptors.request.use(
            (config) => {
                return config;
            },
            (err) => {
                console.log('request error!');
                return Promise.resolve(err);
            },
        );

        this.instance.interceptors.response.use(
            (response) => {
                // 返回响应时做一些处理
                // 第一种方式
                const data = response.data;

                return data;
            },
            (err) => {
                // 当响应异常时做一些处理
                if (err && err.response) {
                    switch (err.response.status) {
                        case 400:
                            err.message = '请求错误(400)';
                            break;
                        case 401:
                            err.message = '未授权，请重新登录(401)';
                            router.push('/login');
                            break;
                        case 403:
                            err.message = '拒绝访问(403)';
                            break;
                        case 404:
                            err.message = '请求出错(404)';
                            break;
                        case 408:
                            err.message = '请求超时(408)';
                            break;
                        case 500:
                            err.message = '服务器错误(500)';
                            break;
                        case 501:
                            err.message = '服务未实现(501)';
                            break;
                        case 502:
                            err.message = '网络错误(502)';
                            break;
                        case 503:
                            err.message = '服务不可用(503)';
                            break;
                        case 504:
                            err.message = '网络超时(504)';
                            break;
                        case 505:
                            err.message = 'HTTP版本不受支持(505)';
                            break;
                        default:
                            err.message = `连接出错(${err.response.status})!`;
                    }
                } else {
                    err.message = '连接服务器失败!';
                }
                console.log(err.message);

                return Promise.resolve(err);
            },
        );
    }

    // public getRequest<T>(url: string, params: any) : AxiosPromise<T> {
    //     return axios({
    //         method: 'get',
    //         url: `${ this.baseUrl }${ url }?`,
    //         params: params,
    //         headers: {
    //             'Content-Type': 'application/x-www-form-urlencoded',
    //             'Access-Token': localStorage.getItem("AccessToken")
    //         }
    //     });
    // }
    //
    // public postRequest<T>(url: string, params: any) : AxiosPromise<T> {
    //     return axios({
    //         method: 'post',
    //         url: `${ this.baseUrl }${ url }`,
    //         data: params,
    //         transformRequest: [ function (data) {
    //             let ret = ''
    //             for (let it in data) {
    //                 ret += encodeURIComponent(it) + '=' + encodeURIComponent(data[it]) + '&'
    //             }
    //             return ret
    //         } ],
    //         headers: {
    //             'Content-Type': 'application/x-www-form-urlencoded'
    //         }
    //     });
    // }
    //
    // public uploadFileRequest<T>(url: string, params: any) : AxiosPromise<T> {
    //     return axios({
    //         method: 'post',
    //         url: `${ this.baseUrl }${ url }`,
    //         data: params,
    //         headers: {
    //             'Content-Type': 'multipart/form-data'
    //         }
    //     });
    // }
    //
    // public putRequest<T>(url: string, params: any) : AxiosPromise<T> {
    //     return axios({
    //         method: 'put',
    //         url: `${ this.baseUrl }${ url }`,
    //         data: params,
    //         transformRequest: [ function (data) {
    //             let ret = ''
    //             for (let it in data) {
    //                 ret += encodeURIComponent(it) + '=' + encodeURIComponent(data[it]) + '&'
    //             }
    //             return ret
    //         } ],
    //         headers: {
    //             'Content-Type': 'application/x-www-form-urlencoded'
    //         }
    //     });
    // }
    //
    // public deleteRequest<T>(url: string, params: any) : AxiosPromise<T> {
    //     return axios({
    //         method: 'delete',
    //         url: `${ this.baseUrl }${ url }`
    //     });
    // }
}
```

## main.ts

```ts
import Vue from 'vue';
import App from './App.vue';
import router from './router';
import store from './store';
import { AxiosService } from '@/components/AxiosService';
import { AxiosStatic } from 'axios';

Vue.config.productionTip = false;

// 註冊 axios
Vue.prototype.$axios = new AxiosService().instance;
declare module 'vue/types/vue' {
    interface Vue {
        $axios: AxiosStatic;
    }
}

new Vue({
    router,
    store,
    render: (h) => h(App),
}).$mount('#app');
```
