# Docker Engine

### [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)

- 可以裝在 ubuntu 22.04 arm64 上

#### Set up the repository

1. 

```bash
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
```

1. 

```bash
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

1. 

```bash
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

1. 

```bash
sudo apt-get update
```

#### Install Docker Engine

1. 

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

1. 

```bash
sudo docker run hello-world
```
