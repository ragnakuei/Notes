
set surround
set clipboard+=unnamed

set nu rnu
nnoremap <A-L> :set rnu!<CR>

let mapleader=','

" 設定搜尋時高亮顯示
set incsearch

" 設定搜尋後高亮顯示
set hlsearch

" 清除高亮搜尋
nnoremap <Leader>sc :nohlsearch<CR>
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
nmap <A-h> <HOME>
imap <A-h> <HOME>
vmap <A-h> <HOME>
nmap <A-l> <END>
imap <A-l> <END>
vmap <A-l> <END>
nmap <C-h> <Left>
imap <C-h> <Left>
vmap <C-h> <Left>
nmap <C-l> <Right>
imap <C-l> <Right>
vmap <C-l> <Right>
nmap <C-j> <Down>
imap <C-j> <Down>
vmap <C-j> <Down>
nmap <C-k> <Up>
imap <C-k> <Up>
vmap <C-k> <Up>
nmap <Leader>f <PageUp>
nmap <Leader>b <PageDown>
vmap <Leader>f <PageUp>
vmap <Leader>b <PageDown>

" 移至外層 { }
" ]} 為同一鍵，因為 } 使用頻率極高，所以只針對 } 做設定
noremap <A-]> ]}
noremap <A-[> [{
voremap <A-]> ]}
voremap <A-[> [{
ioremap <A-]> ]}
ioremap <A-[> [{
" 移至外層 ( ) 
noremap <A-0> ])
noremap <A-9> [(
voremap <A-0> ])
voremap <A-9> [(
ioremap <A-0> ])
ioremap <A-9> [(

nnoremap <leader>; A;<c-[>
nnoremap <leader>, A,<c-[>
nnoremap <leader>a ggVG
