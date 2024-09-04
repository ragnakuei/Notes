# ConversationBufferWindowMemory

- k
  - 用來限制記憶筆數，只會記憶最後 k 筆對話


### 範例

```python
import sys

from langchain.memory import ConversationBufferWindowMemory
from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder
from langchain_core.runnables.history import RunnableWithMessageHistory

from langchainpractice.OpenAI import Initial_ChatOpenAI

# 初始化 OpenAI 接口
llm = Initial_ChatOpenAI.llm

memory = ConversationBufferWindowMemory(k=2, return_messages=True)

prompt = ChatPromptTemplate.from_messages([
    MessagesPlaceholder(variable_name="history"),
    ("human", "{user_input}"),
])

current_session_id = "test_session"

chain_with_history = RunnableWithMessageHistory(
    prompt | llm,
    lambda session_id: memory.chat_memory,
    input_messages_key="user_input",
    history_messages_key="history",
)

while True:
    query = input(f"Prompt: ")

    if query == "exit" or query == "quit" or query == "q" or query == "f":
        break

    if query == '':
        continue

    response = chain_with_history.invoke(
        {"user_input": query},
        config={"configurable": {"session_id": current_session_id}}
    )
    
    # 從這邊就可以看出 memory 能記錄多少筆對話
    print(memory.load_memory_variables({}))
    print()
    print(response)
    print()

print('Exiting')
sys.exit()
```