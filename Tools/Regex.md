# Regex

學習網站
- [RegexLearn](https://regexlearn.com/learn)

## Tokens

- .
  
  代表所有字元

## 排除特定字元

### 身份証字號

開頭是 A-Z，但不包含 Y

> ^((?!Y)[A-Z])[1,2,8,9][0-9]{8}$
> ^(?!Y)[A-Z][1,2,8,9][0-9]{8}$


