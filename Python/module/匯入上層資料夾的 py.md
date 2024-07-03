# 匯入上層資料夾的 py

```py
# 要 import 相對路徑的模組，要先加入路徑
import sys
sys.path.insert(0, '..')

# 再 import 模組，IDE 會報錯，但可以正常執行
import InitialChatOpenAI
model = InitialChatOpenAI.llm
```
