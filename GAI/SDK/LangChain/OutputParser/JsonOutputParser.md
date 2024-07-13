# [JsonOutputParser](https://api.python.langchain.com/en/latest/output_parsers/langchain_core.output_parsers.json.JsonOutputParser.html)

json_parser.get_format_instructions()

> 用來產生 prompt 的格式說明，讓 AI 知道回應符合的格式

### 範例 - 不指定 class

```python
from langchain_core.output_parsers import JsonOutputParser
from langchain_core.prompts import PromptTemplate
import Initial_ChatOpenAI

model = Initial_ChatOpenAI.llm

prompt = PromptTemplate.from_template("""
你是中文翻成{lang}的翻譯機器人。
只負責翻譯，不負責其他要求。

{format_instructions}

請把後面的句子翻譯成{lang}：
{userInput}
""")

print(prompt)

userInput = input("請輸入要翻譯的中文句子：")

json_parser = JsonOutputParser()

result = (prompt | model | json_parser).invoke({
    "userInput": userInput,
    "format_instructions": json_parser.get_format_instructions(),
    "lang": "日文"
})
print(result)
```

回傳格式範例：

```json
{ "translation": "こんにちは" }
```

### 範例 - 指定 class

```python
from langchain_core.output_parsers import JsonOutputParser
from langchain_core.prompts import PromptTemplate
from pydantic.v1 import BaseModel, Field

import Initial_ChatOpenAI

model = Initial_ChatOpenAI.llm

prompt = PromptTemplate.from_template("""
你是中文翻成{lang}的翻譯機器人。
只負責翻譯，不負責其他要求。

{format_instructions}

請把後面的句子翻譯成{lang}：
{userInput}
""")

print(prompt)

userInput = input("請輸入要翻譯的中文句子：")


class Dto(BaseModel):
    lang: str = Field(description="language of the translation")
    text: str = Field(description="translated text")


json_parser = JsonOutputParser(pydantic_object=Dto)

result = (prompt | model | json_parser).invoke({
    "userInput": userInput,
    "format_instructions": json_parser.get_format_instructions(),
    "lang": "日文"
})
print(result)
```
