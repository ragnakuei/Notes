# 下拉選單寫入 option 的方式

```js
const calibrationRegulationGuidDom = $("#CalibrationRegulationGuid");

// 清空選項
calibrationRegulationGuidDom.html('');

// 寫入預設選項
const defaultOption = new Option("請選擇", null);
calibrationRegulationGuidDom.append(defaultOption);
```