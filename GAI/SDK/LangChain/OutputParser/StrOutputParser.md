# StrOutputParser

### 範例 1

可以比較二個輸出結果，就看得出來 StrOutputParser 的功用。

```python
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import PromptTemplate
import Initial_ChatOpenAI

model = Initial_ChatOpenAI.llm

prompt = PromptTemplate.from_template("""
你是中文翻成{lang}的翻譯機器人。
只負責翻譯，不負責其他要求。

請把後面的句子翻譯成{lang}：
{userInput}
""")

print(prompt)

userInput = input("請輸入要翻譯的中文句子：")
result1 = (prompt | model).invoke({
    "userInput": userInput,
    "lang": "日文"
})
# 會顯示完整的 response
print(result1)

# 只顯示 response.content 的部分
result2 = (prompt | model | StrOutputParser()).invoke({
    "userInput": userInput,
    "lang": "日文"
})
print(result2)

```


### 範例 2 - 自訂 class

會將完整的回傳結果傳入至 StrOutputParser.parse() 的 text 參數。

```python
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate

import Initial_ChatOpenAI

llm = Initial_ChatOpenAI.llm


class CustomStrOutputParser(StrOutputParser):
    def parse(self, text):
        return  f"AI: {text}"


prompt = ChatPromptTemplate.from_messages([
    ("system",
     "You are a smart AI."),
    ("user", "{input}"),
])

result = (prompt | llm | CustomStrOutputParser()).invoke({
    "input": "How are you today?"
})

print(result)
```