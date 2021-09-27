# 引用 global.css 的方式

#### 步驟

直接在 main.ts 中加上

```ts
import './assets/css/global.css';
```

就可以了 !

#### 出現 亂碼 $#xFEFF

原因：因為使用 UTF-8 BOM 編碼的關係 !
