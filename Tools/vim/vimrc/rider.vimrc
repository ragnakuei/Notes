mapclear
source D:\Kuei\Notes\Tools\vim\vimrc\common.vimrc

" 安裝 vim-repeat 插件
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-repeat'
call plug#end()
" 啟用 vim-repeat 插件
packadd! vim-repeat


" ideavim 與 vim 的剪貼簿共用
set clipboard+=ideaput

nnoremap <Leader>vc :source D:\Kuei\Notes\Tools\vim\vimrc\rider.vimrc<CR>

" AceJump
nnoremap <Space> :action AceAction<CR>

" run all tests
nnoremap <Leader>ra :action RiderUnitTestRunSolutionAction<CR>


" introduce
nnoremap <Leader>iv :action IntroduceVariable<CR>
nnoremap <Leader>if :action IntroduceField<CR>
"nnoremap <Leader>ip viw:action IntroduceParameter<CR><ESC>
nnoremap <Leader>ip :action IntroduceParameter<CR>
vnoremap <Leader>ip :action IntroduceParameter<CR>

" extract
nnoremap <Leader>em V:action ExtractMethod<CR>
vnoremap <Leader>em :action ExtractMethod<CR>

" SurroundWith
nnoremap <Leader>sw V:action SurroundWith<CR>
vnoremap <Leader>sw :action SurroundWith<CR>


" 建立 nunit test setup 並貼上已複製的內容至 { } 中
nnoremap <Leader>ns ma?[T<CR>O[SetUp]<CR>public void Setup()<CR>{<ESC>po}<ESC>`a:action ReformatCode<CR>

" copy unit test 並將游標移至 void 後的 method name 上
nnoremap <Leader>ct ztmay?[T<CR>`ap?void<CR>w:action ReformatCode<CR>


" shift to visual mode
nnoremap <S-Up> :action EditorUpWithSelection<CR>
nnoremap <S-Down> :action EditorDownWithSelection<CR>
" 這個做法在第一次按下 Shift + Left 時，只會選到第一個字元，而漏掉第二個字元
"nnoremap <S-Left> :action EditorLeftWithSelection<CR>
"nnoremap <S-Right> :action EditorRightWithSelection<CR>
" 這個做法在第一次按下 Shift + Left 時，會選到第一個字元，並且選到第二個字元
nnoremap <S-Left> v<Left><Right><Left>
nnoremap <S-Right> v<Right><Left><Right>
" vnoremap <S-Up> <Up>
" vnoremap <S-k> <Up>
" vnoremap <S-Down> <Down>
" vnoremap <S-j> <Down>
" vnoremap <S-Left> <Left>
" vnoremap <S-Right> <Right>
inoremap <S-Up> <Esc>v<Up>
inoremap <S-Down> <Esc>v<Down>
inoremap <S-Left> <Esc>v<Left>
inoremap <S-Right> <Esc>v<Right>

nnoremap <S-Home> :action EditorLineStartWithSelection<CR>
nnoremap <S-End> :action EditorLineEndWithSelection<CR>
inoremap <S-Home> :action EditorLineStartWithSelection<CR>
inoremap <S-End> :action EditorLineEndWithSelection<CR>
nnoremap <S-Pageup> :action EditorPageUpWithSelection<CR>
nnoremap <S-Pagedown> :action EditorPageDownWithSelection<CR>

" Home / End
nnoremap <Home> :action EditorLineStart<CR>
nnoremap <End> :action EditorLineEnd<CR>
vnoremap <Home> ^
vnoremap <End> $
inoremap <Home> :action EditorLineStart<CR>
inoremap <End> :action EditorLineEnd<CR>

" insert mode
inoremap <C-a> <Esc>ggVG

" VCS
nnoremap <Leader>gr :action ChangesView.Revert<CR>

" error 
" 同檔案 - 避免移至不同的檔案
nnoremap <Leader>ne :action GotoNextError<CR>
vnoremap <Leader>ne :action GotoNextError<CR>

" duplicate line - 因為原本的 IDE 功能不會將游標移至第一個非空白字元，所以用這個代替
nnoremap <C-d> :action EditorDuplicate<CR>^
vnoremap <C-d> :action EditorDuplicate<CR>^