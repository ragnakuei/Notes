mapclear

"--------------------------------------------------------------------------
" Plugin - 目前 VsCodeVim 不支援 plugin
"-------------------------------------------------------------------------
" Plug 'tpope/vim-surround'
"--- package matchit
" Plug 'easymotion/vim-easymotion'
" nnoremap <Space> <Plug>(easymotion-s)
" vnoremap <Space> <Plug>(easymotion-s)

" Plug 'terryma/vim-multiple-cursors'

"--------------------------------------------------------------------------
" Settings
"--------------------------------------------------------------------------

" ideavim 與 vim 的剪貼簿共用
" set clipboard+=ideaput
set clipboard+=unnamed
set visualbell
" 不要有 錯誤提示音
set noerrorbells

set number
set relativenumber
set tabstop=4
set shiftwidth=4

" 設定搜尋時高亮顯示
set incsearch
" 設定搜尋後高亮顯示
set hlsearch

" 只能由 vscode 指定
" let mapleader=','

"--------------------------------------------------------------------------
" Key Mapping
"--------------------------------------------------------------------------

" 重讀設定檔 "無效中
" nnoremap <Leader>vc :source D:\Kuei\Notes\Tools\vim\vimrc\vscode.vimrc<CR>
" 清除高亮搜尋
nnoremap <Leader>sc :nohlsearch<CR>
" 清除高亮搜尋
inoremap <Leader>sc <Esc>:nohlsearch<CR>

" 在 Normal Mode 清除搜尋高亮結果
nnoremap <Esc> :nohlsearch<CR><Esc>

" indent
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Navigation - 不要設定為 noremap 要給實作 <Home> <End> 有額外調整的空間
" nmap <A-h> <HOME>
" imap <A-h> <HOME>
" vmap <A-h> <HOME>
" nmap <A-l> <END>
" imap <A-l> <END>
" vmap <A-l> <END>
" nmap <C-h> <Left>
" imap <C-h> <Left>
" vmap <C-h> <Left>
" nmap <C-l> <Right>
" imap <C-l> <Right>
" vmap <C-l> <Right>
" nmap <C-j> <Down>
" imap <C-j> <Down>
" vmap <C-j> <Down>
" nmap <C-k> <Up>
" imap <C-k> <Up>
" vmap <C-k> <Up>

" 移至外層 { }
" ]} 為同一鍵，因為 } 使用頻率極高，所以只針對 } 做設定
nnoremap <A-]> ]}
nnoremap <A-[> [{
vnoremap <A-]> ]}
vnoremap <A-[> [{

" 移至外層 ( ) 
nnoremap <A-0> ])
nnoremap <A-9> [(
vnoremap <A-0> ])
vnoremap <A-9> [(

" 補上字尾的 ;
" nnoremap <leader>; A;<c-[>
" 補上字尾的 ,
" nnoremap <leader>, A,<c-[>

" 全選
nnoremap <leader>a ggVG
vnoremap <leader>a <ESC>ggVG

nnoremap <S-Left> v<Left><Right><Left>
nnoremap <S-Right> v<Right><Left><Right>
" vnoremap <S-Up> <Up>
" vnoremap <S-k> <Up>
" vnoremap <S-Down> <Down>
" vnoremap <S-j> <Down>
" vnoremap <S-Left> <Left>
" vnoremap <S-Right> <Right>
