# pause 中按 方向鍵 的下，會多跳過一個 pause

問題：

執行以下批次檔時，按下方向鍵的下，會多跳過一個 pause
```
@ECHO OFF

ECHO 1
pause

ECHO 2
pause

ECHO 3
pause

ECHO 4
pause
```


解法：

```
@ECHO OFF

ECHO 1
pause>NUL | set /p var=按下任意鍵繼續..

ECHO 2
pause>NUL | set /p var=Press any key to continue . . .

ECHO 3
pause>NUL | set /p var=按下任意鍵繼續..

ECHO 4
pause>NUL | set /p var=Press any key to continue . . .
```
