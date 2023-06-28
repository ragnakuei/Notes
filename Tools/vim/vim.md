# vim

-   [重新體驗即將失傳的古老技藝 Vim](https://www.youtube.com/watch?v=rhhm2JCZoFY)
-   [再次學習即將失傳的古老技藝 Vim](https://kaochenlong.com/2019/10/16/learning-vim-again/?fbclid=IwAR322GDjkb6AQMCG1rAov8DqMYKcqlbs7FN-76evLyATnRvdeUJm_ntdC7Q)
-   [vimrc-builder](https://vimrc-builder.vercel.app/)
-   [Getting started with vim](https://riptutorial.com/vim)
-   vim 遊戲
    -   [Vim Adventures](https://vim-adventures.com/)
    -   [Vim Snake](https://vimsnake.com/)
    -   [Vim Genius](http://www.vimgenius.com/)
    -   [Openvim](https://www.openvim.com/)

## 待學清單

如何複製片段，再貼上

ctrl + [ => 跟 esc 一樣的功能

進入 visual mode 後，方向鍵取，按下 y 進行複製 => 進行 normal mode

yy => 整行複製

viw => visual => inner select => word
diw => delete => inner select => word
ciw =>

https://vim-adventures.com/

## mode 切換

替代 => shift + H
替代 => shift + L

## move

-   e - 跳到目前字的字尾
-   b - 跳到目前字的字首
-   w - 跳到下一個字的字首
-   B - 跳到下一個字的字首

-   w - 跳到下一個字的字首
-   g e - 跳到上一個字的字尾，不會略過標點符號
-   g E - 跳到上一個字的字尾，不會略過標點符號

## command

| 命令 | 功能             | 說明                                                         |
| ---- | ---------------- | ------------------------------------------------------------ |
| map  | 顯示目前 mapping | [map manual](https://vimhelp.org/map.txt.html#map%2Dlisting) |

## bookmark

| 命令          | 功能              | 說明 |
| ------------- | ----------------- | ---- |
| ma            | 設定書籤 a        |      |
| 'a            | 跳到書籤 a 的行首 |      |
| `a            | 跳到書籤 a        |      |
| :marks        | 顯示所有書籤      |      |
| :delmarks a   | 刪除書籤 a        |      |
| :delmarks a b | 刪除書籤 a, b     |      |
| :delmarks a-b | 刪除書籤 a 到 b   |      |

## 參考資料

[VIM 用户手册](https://yianwillis.github.io/vimcdoc/doc/usr_toc.html)
