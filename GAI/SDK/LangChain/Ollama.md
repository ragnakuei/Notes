# Ollama

### 未整理範例

```python
from langchain_community.llms import Ollama

llm = Ollama(model='llama3:8b')
print(llm.invoke('Hi, how are you today?'))
```

```python
from langchain_ollama.llms import OllamaLLM
llm = OllamaLLM(
    model='llama3.1',
    base_url = 'http://localhost:11435'
)

from langchain_community.llms.ollama import Ollama
llm = Ollama(
    model='llama3.1',
    base_url = 'http://localhost:11435'
)
```


雖然上述語法可執行，但跟 ChatOpenAI 同實作 interface 對應的語法應該是：

```python
from langchain_ollama import ChatOllama
llm = ChatOllama(
    model='llama3.1',
    base_url = 'http://localhost:11435'
)
```