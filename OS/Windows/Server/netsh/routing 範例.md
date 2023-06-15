# routing 範例

設定路由規則：
- 將發送至本機 8080 port 的封包，轉送至 192.168.0.9 的 1483 port

```
netsh interface portproxy add v4tov4 listenport=8080 listenaddress=0.0.0.0 connectport=1483 connectaddress=192.168.0.9
```
刪除上面的規則：

```
netsh interface portproxy delete v4tov4 listenport=5000 listenaddress=0.0.0.0
```