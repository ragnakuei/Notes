# [RabbitMQ](https://hub.docker.com/_/rabbitmq)

---
## 無管理界面

建立 container

> docker run -d -p 5672:5672 --name some-rabbit rabbitmq:3

檢查 log

> docker logs some-rabbit

## 有管理界面

建立 container

> docker run -d --hostname my-rabbit --name some-rabbit -p 15672:15672 rabbitmq:3-management

開啟管理界面

> http://localhost:15672/

[參考資料](https://levelup.gitconnected.com/rabbitmq-with-docker-on-windows-in-30-minutes-172e88bb0808)