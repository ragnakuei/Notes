# [vim-plugin](https://github.com/junegunn/vim-plug)

## 安裝 vim-plug

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## 設定 vim-plug

vim ~/.vimrc

貼上以下內容：

```vim
call plug#begin('~/.vim/plugged')                                                                     

Plug 'junegunn/vim-easy-align'
Plug 'https://github.com/adelarsq/vim-matchit'
Plug 'terryma/vim-multiple-cursors'

call plug#end()
```

儲存後，再開啟 vim，輸入 `:PlugInstall`，就會安裝 vim-easy-align、vim-matchit、vim-multiple-cursors。


### 範例：安裝 vim-matchit

開啟 vim，輸入 `:PlugInstall`，安裝 vim-matchit。
