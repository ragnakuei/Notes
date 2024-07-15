# Embeddings

### 共用元件

```python
class EmbeddingDTO:
    def __init__(self, id: int, text: str, vector: list[float]):
        self.id = id
        self.text = text
        self.vector = vector
        self.score = None


def search_embedding_by_cosing_similarity(doc_embeddings: list[EmbeddingDTO],
                                          query_embeddings: list[float],
                                          top_k=5) -> list[EmbeddingDTO]:
    # 計算查詢向量與所有向量的相似度
    for doc in doc_embeddings:
        doc.score = cosine_similarity(query_embeddings, doc.vector)

    # 根據相似度排序
    doc_embeddings.sort(key=lambda x: x.score, reverse=True)

    # 返回前 k 個最相似的結果
    return doc_embeddings[:top_k]


def cosine_similarity(a: list[float], b: list[float]) -> float:
    # 計算兩個向量的內積
    dot_product = sum([x * y for x, y in zip(a, b)])

    # 計算兩個向量的長度
    a_length = sum([x ** 2 for x in a]) ** 0.5
    b_length = sum([x ** 2 for x in b]) ** 0.5

    # 計算餘弦相似度
    return dot_product / (a_length * b_length)
```

驗証共用元件
計算機
- [Cosine Similarity Calculator](https://www.omnicalculator.com/math/cosine-similarity)

```python
from langchainpractice.OpenAI.EmbeddingsHelper import EmbeddingDTO, cosine_similarity

result = cosine_similarity([0.1, 0.2, 0.3], [0.2, 0.3, 0.4])
print(result)

# 0.9925833339709301
```


### 範例

```python
from langchainpractice.OpenAI import Initial_ChatOpenAI
from langchainpractice.OpenAI.EmbeddingsHelper import EmbeddingDTO, search_embedding_by_cosing_similarity

docs = [
    "蘋果",
    "香蕉",
    "橘子",
    "梨",
    "西瓜",
    "Mac",
    "iPhone",
    "iPad",
    "Apple Watch",
    "Apple TV",
    "Apple Music",
]

embedding_docs: list[EmbeddingDTO] = []

embeddings = Initial_ChatOpenAI.embeddings

for i, doc in enumerate(docs):
    print(f"將 {doc} 轉換為向量...")
    embedding = embeddings.embed_query(doc)

    # 儲存向量資料
    embedding_docs.append(EmbeddingDTO(i, doc, embedding))

print("所有字串已完成轉換\n")

print("取出向量資料庫中的資料:")
for doc in embedding_docs:
    print(f"ID: {doc.id}, 向量: {doc.vector}, 文本: {doc.text}")

# 假設我們有一個查詢文本
query_text = "蘋果 3C 產品"
# query_text = "水果"
query_vector = embeddings.embed_query(query_text)

search_result: list[EmbeddingDTO] = search_embedding_by_cosing_similarity(embedding_docs, query_vector)

print("\n")
print(f"跟 {query_text} 向量搜索排行:")
for result in search_result:
    print(f"ID: {result.id}, 相似度: {result.score}, 文本: {result.text}")
```
