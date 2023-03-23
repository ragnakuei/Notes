# note


Rider 要引用就在 .ideavimrc 加上以下內容即可

```
source x:\yyyyy\rider.vimrc
```

VSCode 要引用就在 .ideavimrc 加上以下內容即可

```
source x:\yyyyy\vscode.vimrc
```


#### 先執行 action1 再執行 Action2

action1 的 id 為 ReformatCode
action2 的 id 為 RiderUnitTestRunSolutionAction

```vim
function! TestAndReFormat()
  if execute('normal! ReformatCode') == 0
    return
  end'
  execute('normal! RiderUnitTestRunSolutionAction')
endfunction

nnoremap <Leader>ra :call TestAndReFormat()<CR>
```

#### 先執行 action1 等待 0.5s 後，再執行 Action2

```vim
function! TestAndReFormat()
    :action ReformatCode
    sleep 500m
    :action RiderUnitTestRunSolutionAction
endfunction

nnoremap <Leader>ra :call TestAndReFormat()<CR>
```