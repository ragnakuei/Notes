# Action Filter

---

## 與 DI 搭配時的流程

簡單說就是，先初始化 instance 才會執行 Action Filter

> DI >> Constructor >> 執行 Action Filter

如果需要在 Constructor 取出 Di Property 的資料，於流程上是做不到的 !

---

## 取得 Controller instance

> filterContext.Controller

---

## 重要資訊

- [不要在 Action Filter 內用 private Dictionary\<TKey, TValue> 來保存資料](https://blog.darkthread.net/blog/actionfilter-attribute-state-preserve/)