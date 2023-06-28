# [vim-surround](https://github.com/tpope/vim-surround)

```vim
set surround
```

### 支援的 text

- { }
- \[ ]
- ( )
- " ' ` ... 等很多的單一字元的符號
- html tag


### 將 text object 包起來

- 方式一：
  先用 view mode 選取 text object 後
  
  > S"
  
  就會將 text 以 "" 包起來
  
- 方式二

  在指定的字串上
  
  > ysiw"
  
  就會將該字串以 "" 包起來


### 將 text object 改用其他符號包起來

如果標點符號結構過於複雜，最好將游標移至要作業的字串內
如果不複雜
- 會先往外找，直到找到一個可以包住該字串的標點符號
- 再往游標所在字元後面行找

將包住的 " 改為 '

from: "hello world"

> cs"'  

to:   'hello world'   

### 將 text object 移除

from: "hello world"

> ds"

to: hello world


### 直接替換成指定 html tag

from: hello world

> cs\<div>

to: \<div>hello world\</div>

### 移除 html tag

from: \<div>hello world\</div>

> dst

to: hello world


### 空格的處理

- 以 { ( [ 這類符號包住 text object 時，會自動產生空格
- 如果不需要加上空格，請改用 對應的 右方符號，例如：] } ) 等

