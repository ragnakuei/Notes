# ideavim

## Normal Mode

| 快速鍵 | 功能 | 說明 |
| ------ | ---- | ---- |
|        |      |      |

### Move

| 快速鍵 | 功能       | 說明 |
| ------ | ---------- | ---- |
| e      | 移至文字尾 |      |
| b      | 移至文字頭 |      |
|        |            |      |
|        |            |      |

| 快速鍵     | 功能                           | 說明 |
| ---------- | ------------------------------ | ---- |
| f + [char] | 往後移至同一行內 [char] 的上面 |      |
| F + [char] | 往前移至同一行內 [char] 的上面 |      |
|            |                                |      |

| 快速鍵 | 功能                               | 說明 |
| ------ | ---------------------------------- | ---- |
| %      | 在 brace 上，移至所對應的 brace 上 |      |
| [{     | 移至游標所在的 { } block 的 { 上   |      |
| ]}     | 移至游標所在的 { } block 的 } 上   |      |
| [(     | 移至游標所在的 ( ) block 的 ( 上   |      |
| ])     | 移至游標所在的 ( ) block 的 ) 上   |      |
|        |                                    |      |

| 快速鍵 | 功能               | 說明 |
| ------ | ------------------ | ---- |
| S + {  | 跳至上一個空白行   |      |
| S + }  | 跳至下一個空白行   |      |
| +      | 移至下一行文字行首 | 加號 |
| \-     | 移至上一行文字行首 | 減號 |
| \_     | 移至該行文字行首   | 底線 |
|        |                    |      |

### Search

| 快速鍵 | 功能     | 說明 |
| ------ | -------- | ---- |
| /      | 往後搜尋 |      |
| ?      | 往前搜尋 |      |

搜尋到 keyword 後

-   用 n 往下一個方向找
-   用 N 往上一個方向找
-   :noh 可以取消 高亮搜尋關鍵字


在 Normal Mode 取消搜尋 Highlight

> 待觀察，是否會影響到 \<Esc> 應有的功能 !

```
nnoremap <Esc> :nohlsearch<CR><Esc>
```

### 取代原本的 搜尋

```
nmap / :action Find<CR>
```

## Visual Mode

### 支援 Tab Indent

```
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
```

測試用，只用以下的語法

```
nnoremap <Tab> >>_
vnoremap <Tab> >gv
```

### Select

```
nmap <S-Home> v<Home>
nmap <S-End> v<End>
nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
imap <S-Up> <Esc>v<Up>
imap <S-Down> <Esc>v<Down>
imap <S-Left> <Esc>v<Left>
imap <S-Right> <Esc>v<Right>
```

## 參考資料

[如何在 Rider 設定 IdeaVim](https://dotblogs.com.tw/yc421206/2020/09/10/rider_config_ideavim)
