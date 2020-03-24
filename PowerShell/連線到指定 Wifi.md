# 連線到指定 Wifi

## 列出所有 Wifi Profiles

> netsh.exe wlan show profiles

預設來說 profile name 與 SSID 是一樣的名字

## 連到指定的 Wifi

ssid 跟 name 都是必填

> netsh wlan connect ssid=WiFiA name=WiFiA

