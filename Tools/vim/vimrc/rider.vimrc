:mapclear
source D:\Kuei\Notes\Tools\vim\vimrc\common.vimrc

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
vnoremap <Leader>ss :action SurroundWith<CR>


" 建立 nunit test setup 並貼上已複製的內容至 { } 中
nnoremap <Leader>ns i[SetUp]<CR>public void Setup()<CR>{<ESC>po}<ESC>:action ReformatCode<CR>

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
vnoremap <S-Up> <Up>
vnoremap <S-k> <Up>
vnoremap <S-Down> <Down>
vnoremap <S-j> <Down>
vnoremap <S-Left> <Left>
vnoremap <S-Right> <Right>
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
vnoremap <Home> :action EditorLineStart<CR>
vnoremap <End> :action EditorLineEnd<CR>
inoremap <Home> :action EditorLineStart<CR>
inoremap <End> :action EditorLineEnd<CR>

" insert mode

" VCS
nnoremap <Leader>gr :action ChangesView.Revert<CR>