# Custom Tool 範例


### 範例 01

```python
import sys
from datetime import timezone

from langchain_core.prompts import PromptTemplate
from langchain.tools import tool
from langchain.tools import BaseTool
from typing import Optional, Union
from langchain_openai import ChatOpenAI

llm = ChatOpenAI(
    model="gpt-4o",
    temperature=0,
    max_tokens=None,
    timeout=None,
    max_retries=2,
    api_key=api_key,
)

@tool
def getUtcDateTime() -> str:
    """回傳目前時間，格式為 yyyy-mm-dd hh:mm:ss。"""
    from datetime import datetime
    # return datetime.utcnow().strftime("%Y-%m-%d %H:%M:%S")
    result = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S")
    print(f"目前 UTC 時間: {result}")
    return result


@tool
def getLocalTimeZone() -> int:
    """回傳目前為 UTC + N 時區的時間，介於 -12 到 +14 之間。"""
    import random
    result = random.randint(-12, 14)
    print(f"目前 UTC + N 時區的時間: {result}")
    return result


tools = [getUtcDateTime, getLocalTimeZone]

from langchain_core.prompts import ChatPromptTemplate, MessagesPlaceholder

prompt = ChatPromptTemplate.from_messages(
    [
        (
            "system",
            """
            1. 取得目前的 UTC 時間 及 UTC + N 的時差後
            2. 以 yyyy-mm-dd hh:mm:ss 的格式回答
            """,
        ),
        ("user", "{input}"),
        MessagesPlaceholder(variable_name="agent_scratchpad"),
    ]
)

llm_with_tools = llm.bind_tools(tools)

from langchain.agents.format_scratchpad.openai_tools import (
    format_to_openai_tool_messages,
)
from langchain.agents.output_parsers.openai_tools import OpenAIToolsAgentOutputParser

agent = (
        {
            "input": lambda x: x["input"],
            "agent_scratchpad": lambda x: format_to_openai_tool_messages(
                x["intermediate_steps"]
            ),
        }
        | prompt
        | llm_with_tools
        | OpenAIToolsAgentOutputParser()
)

from langchain.agents import AgentExecutor

agent_executor = AgentExecutor(agent=agent, tools=tools, verbose=True)

response = agent_executor.invoke({"input": """
1. 請回傳目前 UTC 時間。
2. 以 1 項之時間來回傳目前當地時間
"""})
print(f"回應: {response}")
```