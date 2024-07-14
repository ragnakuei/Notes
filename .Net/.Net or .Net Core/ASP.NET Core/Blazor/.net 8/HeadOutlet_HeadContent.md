# HeadOutlet | HeadContent

只會在 [Prerender](./Prerender.md) 階段才會套用，進入 Render 階段後，就無法套用了 !

在各頁面可以使用下面的方式

```html
<HeadContent>
    <!-- 要放到 html head 上的內容 -->
</HeadContent>
```

來讓內容套用至 App.razor 的 <HeadOutlet />
