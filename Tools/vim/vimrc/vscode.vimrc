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

"--------------------------------------------------------------------------
" Key Mapping
"--------------------------------------------------------------------------

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
nnoremap <leader>; A;<c-[>
" 補上字尾的 ,  " 會跟 EasyMotion 衝突
" nnoremap <leader>, A,<c-[>

" 全選
nnoremap <leader>a ggVG
vnoremap <leader>a <ESC>ggVG
