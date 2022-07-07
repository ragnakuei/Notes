# export 範例 02

從 json 方式匯入

```html
<script lang="javascript" src="https://cdn.sheetjs.com/xlsx-latest/package/dist/xlsx.full.min.js"></script>
<script type="module">
    const XLSX = await import("https://cdn.sheetjs.com/xlsx-0.18.9/package/xlsx.mjs");

    const wb = XLSX.utils.book_new();
    const sheet = wb.book_append_sheet

    // 建立 sheet
    // js object key 為 column
    // 每讀取到新的 js object key 就會依序新增 key
    // 下面的縮排就如同 excel 的內容
    const ws = XLSX.utils.json_to_sheet ([
        { a: 1, b: 2, c: 3 },
              { b: 2, c: 3, d: 4 },
                    { c: 3, d: 4, e: 5 },
    ]);

    XLSX.utils.book_append_sheet(wb, ws, "Sheet1");
    XLSX.writeFile(wb, "SheetJSESMTest.xlsx");
</script>
```