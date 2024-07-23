# 透過 lightbox 無法轉成 project 以及 無法新增 project

解決方式：

project 的 lightbox 需給定 type 欄位 !

```js
gantt.config.lightbox.project_sections = [
    { name: "description", height: 70, map_to: "text", type: "textarea", focus: true },
    { name: "split", type: "checkbox", map_to: "render", options: [{ key: "split", label: "Split Task" }] },
    { name: "time", type: "duration", readonly: true, map_to: "auto" },
    { name: "type", type: "typeselect", map_to: "type" },
];
```