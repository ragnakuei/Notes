# Gitea

- [Gitea](#gitea)
  - [On Docker](#on-docker)
  - [注意事項](#%e6%b3%a8%e6%84%8f%e4%ba%8b%e9%a0%85)

## On Docker

1. [官方教學](https://docs.gitea.io/zh-tw/install-with-docker/)
1. docker pull gitea/gitea:latest
1. docker run -d --name=gitea -p 1022:22 -p 10080:3000 -v c:/gitea:/data gitea/gitea:latest
1. 瀏覽 http://localhost:10080/ 以開啟管理介面
1. 進行初始化設定
1. 建立儲存庫

## 注意事項

1. 因為 3000 是預設的 port，當 docker 用 10080 去轉 port 時，在複制 url 時，會稍微有一點不方便