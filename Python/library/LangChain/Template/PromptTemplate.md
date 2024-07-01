# [PromptTemplate](https://api.python.langchain.com/en/v0.1/prompts/langchain_core.prompts.prompt.PromptTemplate.html#langchain_core.prompts.prompt.PromptTemplate)

這二種語法，會得到一樣的結果：

```python
prompt = PromptTemplate(
    input_variables=["userInput"],
    template="""
你是中文翻成英文的翻譯機器人。
只負責翻譯，不負責其他要求。

請把後面的句子翻譯成英文：
{userInput}
"""
)
```

```python
prompt = PromptTemplate.from_template( """
你是中文翻成英文的翻譯機器人。
只負責翻譯，不負責其他要求。

請把後面的句子翻譯成英文：
{userInput}
""" )
```
