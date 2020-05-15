# form

### 注意

1. submit 時，是看 form 所包住的 dom name，如果 dom 未給定 name 的話，是不會被加進 request body 內的 !

### 限制

1. 不可以是 table、tbody、tr 的子元素

2. form 包住 table 後，在 table 內放 button type=button
透過 jQuery 設定 button.click() 來對 form 進行 submit
會無法成功 submit，`原因不明`
解決方式：直接把 button type 改成 submit 就可以了

3.