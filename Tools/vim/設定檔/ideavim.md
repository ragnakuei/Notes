# ideavim

一些特殊情境：

- 在 insert mode 下，例：AutoComplete，可以脫離 vim 的設定，完全交由 IDE 這邊控制
  - 例 1：
    - 在 Rider 設定了 Ctrl + J 為 EditorDown
    - 在 ideavimrc 中設定了 inoremap \<C-J>
    - 在 ideavim 的 Settings 將衝突的 Shortcut Conflicts 設定為 vim
    - 此時，在 insert mode 中 & 觸發了 AutoComplete，會彈出選單，此時按下 Ctrl + J，會觸發 IDE 上的 EditorDown，而不會觸發 vim 的 inoremap

## 預設設定

ideavim 有預設的 key mapping，其餘的才可以在 `~/.ideavimrc` 中設定

可能的預設設定
- [參考資料 1](https://github.com/aben1188/IdeaVim/blob/master/.ideavimrc)


## [已內建的 plugins](https://github.com/JetBrains/ideavim/wiki/IdeaVim-Plugins)

- [vim-surround](https://github.com/tpope/vim-surround)