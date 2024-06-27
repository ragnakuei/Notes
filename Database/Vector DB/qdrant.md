# [qdrant](https://hub.docker.com/r/qdrant/qdrant)

```bash
docker pull qdrant/qdrant
docker run -d --name qdrant -p 6333:6333 qdrant/qdrant
```

-   預設的 port 為 6333
-   qdrant 執行後，可以 https://localhost:6333/dashboard/ 進入其管理界面
-   設定密碼方式
    -   config.yaml
    -   可以在 docker compose 指定使用本機的 config.yaml
