# 安裝支援 x86_64 架構 Container 的 Ubuntu

[Using Rosetta to run x86-64 Docker Containers and Binaries in Linux virtual machines with Parallels Desktop](https://kb.parallels.com/en/129871)

取得 rosetta_x86_sources.sh

```bash
wget https://kb.parallels.com/Attachments/kcs-193687/rosetta_x86_sources.sh
```

或

```bash
curl -O https://kb.parallels.com/Attachments/kcs-193687/rosetta_x86_sources.sh

```

中間要加上這段 bash command

```bash
chmod 755 rosetta_x86_sources.sh
```

然後再執行

```bash
sudo ./rosetta_x86_sources.sh
sudo apt-get update


sudo docker run  hello-world
sudo docker run --platform linux/amd64 hello-world
```