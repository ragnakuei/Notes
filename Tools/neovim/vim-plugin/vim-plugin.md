# vim-plugin

## windows 安裝方式

在 PowerShell 中執行以下指令

```powershell
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
```


## 設定 vimrc 或 init.vim

以 init.vim 為例，內容如下：

```vim
call plug#begin()
" use VSCode easymotion when in VSCode mode
Plug 'asvetliakov/vim-easymotion'
call plug#end()
```

然後在 nvim 中執行 `:PlugInstall` 即可安裝 vim-easymotion
