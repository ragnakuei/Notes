# reactive 注意事項


### computed

裡面的值如果要放在 js object 中時，就不要從另外二個 computed property 計算出來，否則不會抓到 reactive 的狀態 !

有問題的範例：

```js
const isLogin = computed(() => {
    if (userInfoDtoStore.value.Guid?.length > 0
        && jwt.RefreshToken?.length > 0) {
        return true;
    }

    return false;
});

const roleIsManager = computed(() => userInfoDtoStore.value?.Role === 'Manager');

const mainNav = ref([
    {
        Enable: roleIsManager && isLogin.value === false,
        Text: "管理者首頁",
        Url: '/Manager'
    },
]);
```

正常的範例

```js
const isLogin = computed(() => {
    if (userInfoDtoStore.value.Guid?.length > 0
        && jwt.RefreshToken?.length > 0) {
        return true;
    }

    return false;
});

const roleIsManager = computed(() => isLogin.value && userInfoDtoStore.value?.Role === 'Manager');

const mainNav = ref([
    {
        Enable: roleIsManager,
        Text: "管理者首頁",
        Url: '/Manager'
    },
]);
```

