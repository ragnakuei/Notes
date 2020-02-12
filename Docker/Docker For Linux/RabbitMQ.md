# [RabbitMQ](https://hub.docker.com/_/rabbitmq)

- [RabbitMQ](#rabbitmq)
  - [無管理界面](#%e7%84%a1%e7%ae%a1%e7%90%86%e7%95%8c%e9%9d%a2)
  - [有管理界面](#%e6%9c%89%e7%ae%a1%e7%90%86%e7%95%8c%e9%9d%a2)
  - [檢查 log](#%e6%aa%a2%e6%9f%a5-log)

---
## 無管理界面

建立 container

> docker run -d -p 5672:5672 --name some-rabbit rabbitmq:3

## 有管理界面

建立 container

> docker run -d --hostname my-rabbit --name some-rabbit -p 15672:15672 -p 5672:5672 rabbitmq:3-management

開啟管理界面

> http://localhost:15672/

## 檢查 log

> docker logs some-rabbit

[參考資料](https://levelup.gitconnected.com/rabbitmq-with-docker-on-windows-in-30-minutes-172e88bb0808)