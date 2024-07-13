# [Memory](https://python.langchain.com/v0.1/docs/modules/memory/)

與 GAI 對話，基本上不具備記憶功能，可能的做法

-   自行把對話記錄下來，每次 prompt 時，都把之前的對話加入
-   透過 Memory 這個模組，讓對話具有記憶功能
    -   RunnableWithMessageHistory
