# Mixins

使用無狀態 service 

> 使用有狀態 service => 改用 vuex

- 會比 component 還要早執行
- 同樣享有 vue 本身的生命周期
- 可用來存放共用的 方法 來統一呼叫
- 用起來很像是繼承了一個 class，可以用該 class 上的所有成員
- 可以使用的時機點在 mounted 之後
- mixins 都指定無關 domain 的處理邏輯，與 domain 有關的處理邏輯，請用 abstract class 來共用 !

[typescript 範例](../../2/TypeScript/mixins/local%20範例一.md)