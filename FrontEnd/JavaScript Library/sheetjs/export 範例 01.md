# export 範例 01

array of arry 方式匯入

```html
<script lang="javascript" src="https://cdn.sheetjs.com/xlsx-latest/package/dist/xlsx.full.min.js"></script>
<script type="module">
    const XLSX = await import("https://cdn.sheetjs.com/xlsx-0.18.9/package/xlsx.mjs");

    const wb = XLSX.utils.book_new();
    // 建立 sheet
    // column a、b、c
    // value 為 1、2、3
    const sheet = XLSX.utils.aoa_to_sheet([["a", "b", "c"], [1, 2, 3]]);

    XLSX.utils.book_append_sheet(wb, sheet, "Sheet1");

    XLSX.writeFile(wb, "SheetJSESMTest.xlsx");
</script>
```