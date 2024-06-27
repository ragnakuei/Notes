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

## 基本觀念

### pattern

[count]operation{motion}

## 待學清單

z<Enter> - 將游標所在的行置於畫面中央

gu<Enter> 整行換小寫，Enter 前可加 N，意指往下 N 行

-   guNk 往上 N 行換小寫
-   guNj 往下 N 行換成小寫

gU<Enter> 整行換大寫，Enter 前可加 N

<Ctrl> + w + w - 分割視窗間跳躍
<Crtrl> + R - Redo

normal mode

-   50a=<Esc>
-   4o#<Esc>

<R> Replace Mode

-   => 直接以所在的 word 進行往後搜尋

# => 直接以所在的 word 進行往前搜尋

上述二個按下對應關鍵字後，仍然可以用 n / N 來做搜尋，或是用重複按下原本的 Key 也更為直覺 !

搭配 hls 更為醒目 !

d / x 這類後方要加 motion 的 command 可以搭配 / 來做整合 !

Command

:h keyword

搜尋 keyword 功能

:set is?

:set hls?

ctrl + [ - 跟 esc 一樣的功能

進入 visual mode 後，方向鍵取，按下 y 進行複製 => 進入 normal mode

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

| 命令        | 功能             | 說明                                                         |
| ----------- | ---------------- | ------------------------------------------------------------ |
| map         | 顯示目前 mapping | [map manual](https://vimhelp.org/map.txt.html#map%2Dlisting) |
| set ruler   |                  |                                                              |
| set noruler |                  |                                                              |
| set ruler   | toggle ruler     |                                                              |
|             |                  |                                                              |

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
