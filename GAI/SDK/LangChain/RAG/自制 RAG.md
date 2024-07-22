# 自制 RAG

- [EmbeddingsHelper](../Embeddings.md#共用元件)
- [ParseExcel](../../../../Python/library/解析%20excel.md)

```python
# 將 碳足跡QA.xlsx 裡的問題轉換為向量，並且透過向量搜索找出最相似的問題後，將 問題 及 答案 交給 GAI 來整合回答
import sys

from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate

import Initial_ChatOpenAI
from langchainpractice.OpenAI.EmbeddingsHelper import EmbeddingDTO, search_embedding_by_cosing_similarity
from langchainpractice.OpenAI.ParseExcel import excelToDtos

model = Initial_ChatOpenAI.llm

embedding_docs = []
embeddings = Initial_ChatOpenAI.embeddings

dtos = excelToDtos('碳足跡QA.xlsx')
# for dto in dtos:
#     print(f"ID: {dto.id}\n 問題: {dto.question}\n 答案: {dto.answer}\n\n")


for i, dto in enumerate(dtos):
    print(f"將問題 {dto.question} 轉換為向量...")
    embedding = embeddings.embed_query(dto.question)

    # 儲存向量資料
    embedding_docs.append(EmbeddingDTO(i, dto.question, embedding, {
        "answer": dto.answer,
        "question": dto.question,
    }))

print("所有問題已完成轉換\n")

# print("取出向量資料庫中的資料:")
# for dto in embedding_docs:
#     print(f"ID: {dto.id}\n 向量: {dto.vector}\n 文本: {dto.text} \n\n")

prompt = ChatPromptTemplate.from_messages(
    [
        (
            "system", """
你是碳足跡 QA 機器人，只負責 碳足跡 QA 中的相關問題，不負責其他要求。

###
使用者詢問：{query}
###

###
相關的 context 如下：
{context}
###

請依照 context 裡的資訊來回答使用者的詢問：
""",
        ),
        ("placeholder", "{context}"),
        ("human", "{query}"),
    ]
)

while True:
    query = input(f"請發問: ")

    if (query == "exit"
            or query == "quit"
            or query == "q"
            or query == "f"):
        break

    if query == '':
        continue

    query_vector = embeddings.embed_query(query)

    search_result: list[EmbeddingDTO] = search_embedding_by_cosing_similarity(embedding_docs, query_vector)

    context = []
    print(f"與 {query} 向量搜索排行:")
    for result in search_result:
        print(f"- 相似度: {result.score}, 問題: {result.text}")
        context.append(f"相似度: {result.score}, 問題: {result.text} 答案：{result.dict['answer']}")

    # context: list[str] = [f"相似度: {result.score}, 問題: {result.text} 答案：{result.dict["answer"]}"
    #                       for result in search_result]

    response = (prompt | model | StrOutputParser()).invoke(
        {
            "context": context,
            "query": query
        },
    )
    print("\n")
    print(f"回答: {response}")

print('Exiting')
sys.exit()
```