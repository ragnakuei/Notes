# [script](https://www.learnrazorpages.com/razor-pages/tag-helpers/script-tag-helper)

- [script](#script)
  - [append-version](#append-version)

---

## append-version

幫 src url 加上版號控制，IIS 啟動後，不管 page reload 幾次，都會是相同的 version

> 只對本機檔案有效，對 cdn file 無效

> 除了 IIS 重啟後一定會變更 version 外，不確定何時會變更 version (待確認)

Razor Page 語法如下

```html
<script
    asp-append-version="true"
    src="~/lib/jquery/dist/jquery.min.js"
></script>
```

實際語法如下

```html
<script src="/lib/jquery/dist/jquery.min.js?v=T-aPohYXbm0fRYDpJLr-zJ9RmYTswGsahAoIsNiMld4"></script>
```
