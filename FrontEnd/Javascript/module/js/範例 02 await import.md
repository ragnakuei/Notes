# 範例 02


```html
<script lang="javascript" src="https://cdn.sheetjs.com/xlsx-latest/package/dist/xlsx.full.min.js"></script>
<script type="module">
    const XLSX = await import("https://cdn.sheetjs.com/xlsx-0.18.9/package/xlsx.mjs");

    const wb = XLSX.utils.book_new();
    const ws = XLSX.utils.aoa_to_sheet([["a", "b", "c"], [1, 2, 3]]);
    XLSX.utils.book_append_sheet(wb, ws, "Sheet1");
    XLSX.writeFile(wb, "SheetJSESMTest.xlsx");
</script>
```