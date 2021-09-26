# 加入 string.prototype 自制 function

#### 方式：實作在 main.ts 中

1. 新增檔案 typings.d.ts

    - 與 main.ts 同目錄內

    ```ts
    interface String {
        to_yyyy_MM_dd(): string;

        to_hh_mm(): string;
    }
    ```
1. main.ts 新增其實作

    ```ts
    // 原本 main.ts 的內容，略 ...

    // 將後端給的日期資料 yyyy/MM/ddTHH:mm:ss 轉成 yyyy-MM-dd
    String.prototype.to_yyyy_MM_dd = function () {
        return this.split('T')[0].replace('/', '-');
    }

    // 將後端給的日期資料 HH:mm:ss 轉成 HH:mm
    String.prototype.to_hh_mm = function () {

        // console.log(this);

        return this.includes('T')
            ? this.split('T')[1].substring(0, 5)
            : this.substring(0, 5);
    }
    ```

#### 方式：實作在獨立檔案中，以 function 方式執行

1. 新增檔案 typings.d.ts

    - 與 main.ts 同目錄內

    ```ts
    interface String {
        to_yyyy_MM_dd(): string;

        to_hh_mm(): string;
    }
    ```

1. 建立檔案 string.extensions.ts

    - 與 main.ts 同目錄內

    ```ts
    export default function RegisterStringExtensions() {
        console.log('run StringExtensions Ctor');

        // 將後端給的日期資料 yyyy/MM/ddTHH:mm:ss 轉成 yyyy-MM-dd
        String.prototype.to_yyyy_MM_dd = function () {
            return this.split('T')[0].replace('/', '-');
        }

        // 將後端給的日期資料 HH:mm:ss 轉成 HH:mm
        String.prototype.to_hh_mm = function () {

            // console.log(this);

            return this.includes('T')
                ? this.split('T')[1].substring(0, 5)
                : this.substring(0, 5);
        }
    }

    ```

1. main.ts 新增呼叫

    ```ts
    import RegisterStringExtensions from "./string.extensions";

    // 原本 main.ts 的內容，略 ...

    RegisterStringExtensions();
    ```

#### 方式：實作在獨立檔案中，以 class 方式執行

1. 新增檔案 typings.d.ts

    - 與 main.ts 同目錄內

    ```ts
    interface String {
        to_yyyy_MM_dd(): string;

        to_hh_mm(): string;
    }
    ```

1. 建立檔案 string.extensions.ts

    - 與 main.ts 同目錄內

    ```ts
    export class StringExtensions {
        constructor() {

            console.log('run StringExtensions Ctor');

            // 將後端給的日期資料 yyyy/MM/ddTHH:mm:ss 轉成 yyyy-MM-dd
            String.prototype.to_yyyy_MM_dd = function () {
                return this.split('T')[0].replace('/', '-');
            }

            // 將後端給的日期資料 HH:mm:ss 轉成 HH:mm
            String.prototype.to_hh_mm = function () {

                // console.log(this);

                return this.includes('T')
                    ? this.split('T')[1].substring(0, 5)
                    : this.substring(0, 5);
            }
        }
    }
    ```

1. main.ts 新增呼叫

    ```ts
    import { StringExtensions } from "./string.extensions";

    // 原本 main.ts 的內容，略 ...

    new StringExtensions();
    ```

#### 方式：在 index.html 直接引用

1. 新增檔案 typings.d.ts

    - 與 main.ts 同目錄內

    ```ts
    interface String {
        to_yyyy_MM_dd(): string;

        to_hh_mm(): string;
    }
    ```

1. 建立檔案 string.extensions.js

    - 放在 /srv/assets/js/ 中

    ```js
    console.log('run StringExtensions Ctor');

    // 將後端給的日期資料 yyyy/MM/ddTHH:mm:ss 轉成 yyyy-MM-dd
    String.prototype.to_yyyy_MM_dd = function () {
        return this.split('T')[0].replace('/', '-');
    }

    // 將後端給的日期資料 HH:mm:ss 轉成 HH:mm
    String.prototype.to_hh_mm = function () {

        // console.log(this);

        return this.includes('T')
            ? this.split('T')[1].substring(0, 5)
            : this.substring(0, 5);
    }
    ```

1. 在 index.html 直接引用

```html
<script src="./assets/js/string.extensions.js"></script>
```