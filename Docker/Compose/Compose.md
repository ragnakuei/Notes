# [Compose](https://docs.docker.com/compose/)

讀取設定檔之檔名:docker-compose.yml

## arguments	

-f file	指定 compose file

## docker-compose指令	

[build](https://docs.docker.com/compose/reference/build/)

[up](https://docs.docker.com/compose/reference/up/)

[run](https://docs.docker.com/compose/reference/run/)
	

## 欄位參數說明

	
images 會有二種情況:
    
    給定 Dockerfile:
	    宣告建立的 image name

	未給定 Dockerfile:
	    宣告此 container 使用的 image name ，必定是 lower case

build

- context  工作目錄，dockerfile 的 COPY 會以這個為相對路徑

- dockerfile  Dockerfile 所在目錄

---

## 參考資料

- [Multi-Container Applications](https://github.com/docker/labs/blob/master/windows/windows-containers/MultiContainerApp.md)

