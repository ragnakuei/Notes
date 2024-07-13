# OpenAI

- 回傳資料類型已經是 BaseMessage，不需要再經過 OutputParser


### 共用程式碼

```python
import langchain
from langchain_openai import ChatOpenAI, OpenAIEmbeddings

# Set the verbosity of the library
langchain.verbose = False
langchain.debug = False
langchain.llm_cache = False

api_key = ""

llm = ChatOpenAI(
    model="gpt-4o",
    temperature=0,
    max_tokens=None,
    timeout=None,
    max_retries=2,
    api_key=api_key,
)

embeddings = OpenAIEmbeddings(
    model="text-embedding-3-large",
    api_key=api_key,
)
```




```python
from Initial_ChatOpenAI import llm

messages = [
    (
        "system",
        "You are a helpful assistant that translates English to French. Translate the user sentence.",
    ),
    ("human", "I love programming."),
]
ai_msg = llm.invoke(messages)

print(ai_msg.content)
print(ai_msg.response_metadata)
```
