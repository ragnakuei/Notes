# Ollama

參考資料

-   https://www.youtube.com/watch?v=JpQC0W91E6k

## 指令

抓取指定的 model

-   ollama pull llama3
-   ollama pull llama3:8b
-   ollama pull llama3:70b

執行指定的 model (.如果 model 不存在，則會先 pull )

-   ollama run llama3

## 安裝

安裝完畢後，就會預設讀取 GPU 資源
https://ollama.com/blog/windows-preview

GPU 支援列表
https://github.com/ollama/ollama/blob/main/docs/gpu.md

### docker hub

-   https://hub.docker.com/r/ollama/ollama

```bash
docker run -d -p 11434:11434 --name ollama ollama/ollama
docker exec -it ollama /bin/bash
docker exec -it ollama ollama pull llama3:7b
```
