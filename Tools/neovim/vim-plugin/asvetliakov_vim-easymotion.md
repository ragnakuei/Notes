# [asvetliakov/vim-easymotion](https://github.com/easymotion/vim-easymotion)

[完整 key mapping](https://github.com/easymotion/vim-easymotion/blob/master/doc/easymotion.txt)

-   預設的 leader key 是 `<leader><leader>`，可以在 `init.vim`設定

常用 key mapping:

| key mapping               | 功能                                          |
| ------------------------- | --------------------------------------------- |
| \<leader>\<leader>s{char} | 全域尋找 char                                 |
| \<leader>\<leader>f{char} | 往後尋找 char，並顯示 char 後一個字元為跳躍點 |
| \<leader>\<leader>F{char} | 往前尋找 char，並顯示 char 後一個字元為跳躍點 |
| \<leader>\<leader>t{char} | 往後尋找 char，並顯示 char 前一個字元為跳躍點 |
| \<leader>\<leader>T{char} | 往前尋找 char，並顯示 char 前一個字元為跳躍點 |
| \<leader>\<leader>j       | 顯示後 N 行之行首為跳躍點                     |
| \<leader>\<leader>k       | 顯示前 N 行之行首為跳躍點                     |
|                           |                                               |

其餘 w / b / e / ge ... 之類的，都是類似的用法，不再贅述。
