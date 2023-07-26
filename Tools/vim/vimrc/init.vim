if exists('g:vscode')
    " VSCode extension
else
    " ordinary Neovim
endif


"----------------------------------------------------------------------
" Plugins
"----------------------------------------------------------------------
call plug#begin()

" 搭配 VSCode 才能用的套件
Plug 'easymotion/vim-easymotion'
nnoremap <Space> <Plug>(easymotion-s)
vnoremap <Space> <Plug>(easymotion-s)

Plug 'tpope/vim-surround'
Plug 'https://github.com/adelarsq/vim-matchit'
Plug 'terryma/vim-multiple-cursors'
" vscode-neovim 無法 sync selection => https://github.com/vscode-neovim/vscode-neovim/issues/97
let g:multi_cursor_next_key            = '<C-S-d>'

call plug#end()

"----------------------------------------------------------------------
" Basic Options
"----------------------------------------------------------------------
set clipboard+=unnamedplus
set number
set relativenumber
set shiftwidth=4
set tabstop=4

" The <leader> key
let mapleader=","

"----------------------------------------------------------------------
" Key Mapping
"----------------------------------------------------------------------

" 重新讀取設定檔
map <silent> <leader>r :source D:\Kuei\Notes\Tools\vim\vimrc\init.vim<cr>

" 清除高亮搜尋
nnoremap <Leader>sc :nohlsearch<CR>
" 清除高亮搜尋
inoremap <Leader>sc <Esc>:nohlsearch<CR>
" 在 Normal Mode 清除搜尋高亮結果
nnoremap <Esc> :nohlsearch<CR>

" 全選
nnoremap <leader>a ggVG
vnoremap <leader>a <ESC>ggVG

nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
