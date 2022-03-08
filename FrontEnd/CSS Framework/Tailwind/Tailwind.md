# [Tailwind](https://tailwindcss.com/docs/guides)


[排版神器 Tailwind CSS～和兔兔一起快速上手漂亮的元件開發！](https://ithelp.ithome.com.tw/m/articles/10259296)


### 在 vite 安裝

1. [第一步](https://tailwindcss.com/docs/guides/vite)
1. [第二步](https://tailwindcss.com/docs/using-with-preprocessors)
    
    引用順序有差，要注意 !

    1. src/index.css 移至 src/styles/ 中
    1. main.ts / main.js 引用 index.css 的路徑要改成

        ```ts
        import './styles/index.css'
        ```
    1. index.css 將以下的語法

        ```css
        @tailwind base;
        @tailwind components;
        @tailwind utilities;
        ```

        改為

        ```css
        @import 'tailwindcss/base';
        @import 'tailwindcss/components';
        @import 'tailwindcss/utilities';
        ```

1. [nesting](https://tailwindcss.com/docs/using-with-preprocessors#nesting)
