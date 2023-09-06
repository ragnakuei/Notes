# vscode neovim 設定方式

1. [安裝 neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-download)
1. VSCode 安裝 [vscode-neovim](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim)
1. VScode 設定 settings.json

    ```json
    "vscode-neovim.logOutputToConsole": true,
    "vscode-neovim.neovimExecutablePaths.win32": "C:\\Program Files\\Neovim\\bin\\nvim.exe",
    "vscode-neovim.neovimInitVimPaths.win32": "C:\\Users\\Kuei\\AppData\\Local\\nvim\\init.vim",
    "editor.lineNumbers": "relative"
    ```
1. 建立 init.vim

    ```vim
    if exists('g:vscode')
        " VSCode extension
    else
        " ordinary Neovim
    endif



    "----------------------------------------------------------------------
    " Plugins
    "----------------------------------------------------------------------
    call plug#begin()
    " use VSCode easymotion when in VSCode mode
    Plug 'asvetliakov/vim-easymotion'
    call plug#end()

    set clipboard+=unnamedplus

    "----------------------------------------------------------------------
    " Basic Options
    "----------------------------------------------------------------------
    let mapleader=","        " The <leader> key



    "----------------------------------------------------------------------
    " Key Mapping
    "----------------------------------------------------------------------

    map <silent> <leader>r :source C:\Users\Kuei\AppData\Local\nvim\init.vim<cr>  " 重新讀取設定檔

    nnoremap <leader>a ggVG           " 全選
    vnoremap <leader>a <ESC>ggVG      " 全選

    ```

 