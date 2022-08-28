# [nextTick](https://vuejs.org/v2/api/#Vue-nextTick)



#### 可解決的情境
 
情境 01 ：

```
父 component 
- template 內給定 子 component，並給定 prop (以下稱 propA，型別為 Object)
- 使用 ref 來指向子 component 

發生流程：
在父 component 先給定 propA 的值後，再透過 子 component ref 呼叫 method !
在子 component method 內，重新取出 propA.propertyB 的值，都會取到上次 binding 的值 !

猜測主要問題：使用 ref 指向 component 後，直接呼叫 comonent 執行動作 !

-------------

必須在父 component 給定 propA 的值後，加上 nextTick 才會來得及更新子 component prop 的值 !
```

#### vue 3

- 要記得 import

```js
await nextTick();
```