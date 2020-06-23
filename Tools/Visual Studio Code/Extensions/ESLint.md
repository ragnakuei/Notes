# ESLint

會讀取資料夾內的 .eslintrc.js 的 ESLint 設定來進行 es lint 的動作 !

## 支援 prettier 的設定

要有 `"prettier:recommended"` 的設定

> 原本可能是 `"eslint:recommended"`

```json
extends: [
    "plugin:vue/essential",
    "prettier:recommended",
    "@vue/prettier"
    ],
```
