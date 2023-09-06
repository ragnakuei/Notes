# 重新整理頁面後 scroll 至原本瀏覽的位置

注意：
> 不要一開始就 或是在 window.onload 中，直接呼叫 scroller.initial()
> 因為此時 scrollPosition 還沒有被設定，會導致就算 initial() 完畢，還是 scroll 至 0 的位置。


功能程式：

```js
window.scroller = {
  initial: async function () {
    scroller.scrollToPosition();
    scroller.registerEvent();
  },
  registerEvent: function () {
    window.removeEventListener("scroll", scroller.scrollEvent);

    window.addEventListener("scroll", scroller.scrollEvent);
  },
  scrollEvent: function () {
    const scrollPosition = window.scrollY;

    // console.log("scrollPosition", scrollPosition);

    scroller.setScrollPosition(scrollPosition);
  },
  scrollToPosition: function () {
    const scrollPosition = scroller.getScrollPosition();

    // console.log("scrollToPosition", scrollPosition);

    window.scrollTo(0, scrollPosition);
  },

  // Local Storage
  localStorageKey: "scrollPosition",
  setScrollPosition: function (scrollPosition) {
    const storeObject = {};
    storeObject[window.location.href] = scrollPosition;

    // console.log("setScrollPosition", storeObject);

    localStorage.setItem(scroller.localStorageKey, JSON.stringify(storeObject));
  },
  getScrollPosition: function () {
    const storeObject = JSON.parse(localStorage.getItem(scroller.localStorageKey)) || {};

    // console.log("get storeObject", storeObject);

    const scrollPosition = storeObject[window.location.href] || 0;

    // console.log("get scrollPosition", scrollPosition);

    return scrollPosition;

    // 測試用，確認此功能是否正常
    // return scrollPosition + 100;
  },
};
```